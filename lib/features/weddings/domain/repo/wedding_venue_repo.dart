// Outlines the venue operations
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';

abstract class WeddingVenueRepo {
  //get/listen to venues from database
  Stream<List<WeddingVenue>> getWeddingVenuesStream();

  //! DEPRECATED
  Future<List<WeddingVenue>> getAllVenues();
}
