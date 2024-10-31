//todo this eventually will be extended to add farms,football.
abstract class OwnerRepo {
  Future<void> addVenueToDatabase({
    required String name,
    required String lat,
    required String lon,
    required String ownerId,
    List<String>? pics,
  });
}
