import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/features/owner/domain/repo/owner_repo.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';

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
    //create weddingVenue object
    WeddingVenue weddingVenue = WeddingVenue(
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
        .add(weddingVenue.toJson());
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
