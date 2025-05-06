import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/endpoints.dart';
import 'package:events_jo/features/events/shared/domain/models/football_court.dart';
import 'package:events_jo/features/owner/domain/models/stripe_connect.dart';
import 'package:events_jo/features/owner/domain/repo/owner_repo.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_detailed.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_drink.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_meal.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class FirebaseOwnerRepo implements OwnerRepo {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //setup cloudinary server (for image upload & removal)
  final cloudinary = Cloudinary.full(
    apiKey: dotenv.get('IMG_API_KEY'),
    apiSecret: dotenv.get('IMG_API_SECRET'),
    cloudName: dotenv.get('IMG_CLOUD_NAME'),
  );

  @override
  Future<void> addVenueToDatabase({
    required String name,
    required double lat,
    required double long,
    required String ownerId,
    required String ownerName,
    required int peopleMax,
    required int peopleMin,
    required double peoplePrice,
    required List<int> startDate,
    required List<int> endDate,
    required List<int> time,
    required String stripeAccountId,
    List<String>? pics,
    List<WeddingVenueMeal>? meals,
    List<WeddingVenueDrink>? drinks,
  }) async {
    //set venue id
    final String docId = generateUniqueId();

    //create weddingVenue object
    WeddingVenue weddingVenue = WeddingVenue(
      id: docId,
      latitude: lat,
      longitude: long,
      name: name.toTitleCase,
      startDate: startDate,
      endDate: endDate,
      time: time,
      isOpen: true,
      isApproved: false,
      isBeingApproved: false,
      peopleMax: peopleMax,
      peopleMin: peopleMin,
      peoplePrice: peoplePrice,
      ownerId: ownerId,
      ownerName: ownerName,
      stripeAccountId: stripeAccountId,
      pics: pics ?? [],
      rates: [],
      city: await getCity(lat, long) ?? 'Not Found',
    );

    // add new venue to database
    await FirebaseFirestore.instance
        .collection('venues')
        .doc(docId)
        .set(weddingVenue.toJson());

    //team we use (set) instead of (add) so we can specify the id
    //in this case we have the id as (current time) + (rand num) because it's always unique
    //if (add) is used Firebase will generate random id.

    //------------------Meals---------------------

    await addVenueMealsToDatabase(meals, docId);

    //------------------Drinks--------------------

    await addVenueDrinksToDatabase(drinks, docId);
  }

  Future<void> addCourtToDatabase(FootballCourt court) async {
    //add new court to database
    await firebaseFirestore
        .collection('courts')
        .doc(court.id)
        .set(court.toJson());
  }

  @override
  Future<String?> getCity(double lat, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

      return placemarks[0].locality;
    } catch (e) {
      return '  ';
    }
  }

  @override
  Future<void> addVenueMealsToDatabase(
      List<WeddingVenueMeal>? meals, String docId) async {
    //user didn't add meals
    if (meals == null || meals.isEmpty) {
      return;
    }

    //fixed meals id
    for (int i = 0; i < meals.length; i++) {
      meals[i].id = (i + 1).toString();
    }

    //add meals collection to user's venue
    //then add user's individual meals
    for (int i = 0; i < meals.length; i++) {
      await FirebaseFirestore.instance
          .collection('venues')
          .doc(docId)
          .collection('meals')
          .doc(meals[i].id)
          .set(meals[i].toJson());
    }
  }

  @override
  Future<void> addVenueDrinksToDatabase(
      List<WeddingVenueDrink>? drinks, String docId) async {
    //user didn't add drinks
    if (drinks == null || drinks.isEmpty) {
      return;
    }

    //fixed drinks id
    for (int i = 0; i < drinks.length; i++) {
      drinks[i].id = (i + 1).toString();
    }

    //add drinks collection to user's venue
    //then add user's individual drinks
    for (int i = 0; i < drinks.length; i++) {
      await FirebaseFirestore.instance
          .collection('venues')
          .doc(docId)
          .collection('drinks')
          .doc(drinks[i].id)
          .set(drinks[i].toJson());
    }
  }

  @override
  Future<void> updateVenueInDatabase(
      WeddingVenueDetailed venueDetailed, List<dynamic> updatedImages) async {
    final venue = venueDetailed.venue;
    final meals = venueDetailed.meals;
    final drinks = venueDetailed.drinks;

    //--images--
    List<dynamic> tempImages = List.from(updatedImages);

    for (int i = 0; i < tempImages.length; i++) {
      //existing images
      if (i < venue.pics.length) {
        //[index][1] == 0 -> keep
        //[index][1] == 1 -> delete
        if (tempImages[i][1] == 1) {
          await deleteImagesFromServer([XFile(tempImages[i][0])]);
          tempImages.removeAt(i);
          i--;
        }
      }
      //new images
      else {
        //[index][1] == 0 -> add
        //[index][1] == 1 -> ignore
        if (tempImages[i][1] == 0) {
          final url =
              await addImagesToServer([XFile(tempImages[i][0])], venue.name);
          tempImages[i] = [url[0], 0];
        } else {
          tempImages.removeAt(i);
          i--;
        }
      }
    }

    venue.pics = tempImages.map((image) => image[0] as String).toList();

    try {
      //update the main venue document
      await firebaseFirestore
          .collection('venues')
          .doc(venue.id)
          .update(venue.toJson());

      // Update the meals subcollection
      final mealsCollection = firebaseFirestore
          .collection('venues')
          .doc(venue.id)
          .collection('meals');

      // Clear existing meals
      final existingMeals = await mealsCollection.get();
      for (var mealDoc in existingMeals.docs) {
        await mealDoc.reference.delete();
      }

      // Add updated meals
      if (meals.isNotEmpty) {
        for (var meal in meals) {
          await mealsCollection.doc(meal.id).set(meal.toJson());
        }
      }

      // Update the drinks subcollection
      final drinksCollection = firebaseFirestore
          .collection('venues')
          .doc(venue.id)
          .collection('drinks');

      // Clear existing drinks
      final existingDrinks = await drinksCollection.get();
      for (var drinkDoc in existingDrinks.docs) {
        await drinkDoc.reference.delete();
      }

      // Add updated drinks
      if (drinks.isNotEmpty) {
        for (var drink in drinks) {
          await drinksCollection.doc(drink.id).set(drink.toJson());
        }
      }
    } catch (e) {
      throw Exception('Failed to update venue: ${e.toString()}');
    }
  }

  @override
  Future<void> updateCourtInDatabase(
      FootballCourt footballCourt, List<dynamic> updatedImages) async {
    //--images--
    List<dynamic> tempImages = List.from(updatedImages);

    for (int i = 0; i < tempImages.length; i++) {
      //existing images
      if (i < footballCourt.pics.length) {
        //[index][1] == 0 -> keep
        //[index][1] == 1 -> delete
        if (tempImages[i][1] == 1) {
          await deleteImagesFromServer([XFile(tempImages[i][0])]);
          tempImages.removeAt(i);
          i--;
        }
      }
      //new images
      else {
        //[index][1] == 0 -> add
        //[index][1] == 1 -> ignore
        if (tempImages[i][1] == 0) {
          final url = await addImagesToServer(
              [XFile(tempImages[i][0])], footballCourt.name);
          tempImages[i] = [url[0], 0];
        } else {
          tempImages.removeAt(i);
          i--;
        }
      }
    }

    footballCourt.pics = tempImages.map((image) => image[0] as String).toList();

    try {
      //update the main venue document
      await firebaseFirestore
          .collection('courts')
          .doc(footballCourt.id)
          .update(footballCourt.toJson());
    } catch (e) {
      throw Exception('Failed to update court: ${e.toString()}');
    }
  }

  @override
  Future<List<String>> addImagesToServer(
      List<XFile> images, String name) async {
    List<String> urls = [];
    urls.clear();

    final time = DateTime.now().millisecond;

    // request upload to server
    for (int i = 0; i < images.length; i++) {
      var response = await cloudinary.uploadResource(
        CloudinaryUploadResource(
          filePath: images[i].path,
          fileBytes: await images[i].readAsBytes(),
          folder: '$name-$time',
          resourceType: CloudinaryResourceType.image,
        ),
      );

      if (response.isSuccessful) {
        urls.add(response.secureUrl ?? '');
      }
    }

    return urls;
  }

  @override
  Future<void> deleteImagesFromServer(List<XFile> images) async {
    try {
      // request upload to server
      for (int i = 0; i < images.length; i++) {
        var response = await cloudinary.deleteResource(
          cloudinaryImage: CloudinaryImage(images[i].path),
          resourceType: CloudinaryResourceType.image,
        );

        if (response.isSuccessful) {}
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<WeddingVenueDetailed>> getOwnerVenues(String ownerId) async {
    final querySnapshot = await firebaseFirestore
        .collection('venues')
        .where('ownerId', isEqualTo: ownerId)
        .get();

    List<WeddingVenueDetailed> venuesDetailed = [];

    for (var doc in querySnapshot.docs) {
      final venue = WeddingVenue.fromJson(doc.data());

      final mealsSnapshot = await firebaseFirestore
          .collection('venues')
          .doc(venue.id)
          .collection('meals')
          .get();

      final meals = mealsSnapshot.docs
          .map(
            (mealDoc) => WeddingVenueMeal.fromJson(
              mealDoc.data(),
            ),
          )
          .toList();

      final drinksSnapshot = await firebaseFirestore
          .collection('venues')
          .doc(venue.id)
          .collection('drinks')
          .get();

      final drinks = drinksSnapshot.docs
          .map(
            (drinkDoc) => WeddingVenueDrink.fromJson(
              drinkDoc.data(),
            ),
          )
          .toList();

      venuesDetailed.add(
          WeddingVenueDetailed(venue: venue, meals: meals, drinks: drinks));
    }
    return venuesDetailed;
  }

  @override
  Future<List<FootballCourt>> getOwnerCourts(String ownerId) async {
    final querySnapshot = await firebaseFirestore
        .collection('courts')
        .where('ownerId', isEqualTo: ownerId)
        .get();
    List<FootballCourt> courts = [];

    for (var doc in querySnapshot.docs) {
      final court = FootballCourt.fromJson(doc.data());
      courts.add(court);
    }

    return courts;
  }

  @override
  String generateUniqueId() {
    //current time (from year to microsecond)
    final now = DateTime.now();
    //get random number between 0 and 99999
    int randomValue = Random().nextInt(100000);

    //id example -> 2024111609413072511999
    return "${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}${now.microsecond}$randomValue";
  }

  @override
  Stream<String?> listenToOnboardingStatus(String ownerId) {
    return firebaseFirestore
        .collection('owners')
        .doc(ownerId)
        .snapshots()
        .map((snapshot) => snapshot.data()?['onboardingStatus'] as String?);
  }

  //onboarding stripe
  @override
  Future<StripeConnect> startOnboarding(String userId) async {
    try {
      final res = await http.post(
        Uri.parse(kCreateConnectedAccount),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId}),
      );

      final data = jsonDecode(res.body);
      return StripeConnect(
        stripeAccountId: data['accountId'],
        onboardingUrl: data['url'],
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
