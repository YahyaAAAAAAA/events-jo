import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';

abstract class AdminRepo {
  Future<void> deleteImagesFromServer(List<String> urls);

  Stream<List<WeddingVenue>> getWeddingVenuesRequestsStream();

  Future<String> getWeddingOwnerName(String uid);
}
