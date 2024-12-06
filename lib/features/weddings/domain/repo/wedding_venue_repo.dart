// Outlines the venue operations
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';

abstract class WeddingVenueRepo {
  //get/listen to venues from database
  Stream<QuerySnapshot<Map<String, dynamic>>> getWeddingVenuesStream();

  //! DEPRECATED
  Future<List<WeddingVenue>> getAllVenues();

  String generateUniqueId();
}
