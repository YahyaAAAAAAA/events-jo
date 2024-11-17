// Outlines the venue operations
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';

abstract class WeddingVenueRepo {
  Future<List<WeddingVenue>> getAllVenues();
}
