import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/features/owner/domain/repo/owner_repo.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cloudinary_api/src/request/model/uploader_params.dart';
import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseOwnerRepo implements OwnerRepo {
  @override
  Future<void> addVenueToDatabase({
    required String name,
    required String lat,
    required String lon,
    required String ownerId,
    required List<int> startDate,
    required List<int> endDate,
    required List<int> time,
    List<String>? pics,
  }) async {
    //set venue id
    final String docId = generateUniqueId();

    //create weddingVenue object
    WeddingVenue weddingVenue = WeddingVenue(
      id: docId,
      latitude: lat,
      longitude: lon,
      name: name.toTitleCase,
      startDate: startDate,
      endDate: endDate,
      time: time,
      isOpen: true,
      owner: ownerId,
      pics: pics ??
          [
            'https://i.ibb.co/ZVf53hB/placeholder.png',
          ],
      rate: 0,
    );

    // add new venue to database
    await FirebaseFirestore.instance
        .collection('venues')
        .doc(docId)
        .set(weddingVenue.toJson());

    //team we use (set) instead of (add) so we can specify the id
    //in this case we have the id as (current time) + (rand num) because it's always unique
    //if (add) is used Firebase will generate random id.
  }

  @override
  Future<List<String>> addImagesToServer(List<XFile> images) async {
    //setup Cloudinary server
    var cloudinary = await Cloudinary.fromStringUrl(
        'cloudinary://${dotenv.get('IMG_API_KEY')}:${dotenv.get('IMG_API_SECRET')}@${dotenv.get('IMG_CLOUD_NAME')}');

    //server config
    cloudinary.config.urlConfig.secure = true;

    List<String> urls = [];
    urls.clear();

    // request upload to server
    for (int i = 0; i < images.length; i++) {
      var response = await cloudinary.uploader().upload(
            File(images[i].path),
            params: UploadParams(
              uniqueFilename: true,
              overwrite: true,
            ),
          );
      urls.add(response!.data!.secureUrl ?? '');
    }

    return urls;
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
}

//extend string class -> capitalize the beginning of every word
extension StringCasingExtension on String {
  String get toCapitalized =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String get toTitleCase => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized)
      .join(' ');
}
