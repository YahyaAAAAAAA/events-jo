import 'package:cloud_firestore/cloud_firestore.dart';

abstract class OwnerVenuesRepo {
  Stream<QuerySnapshot<Map<String, dynamic>>> getApprovedVenuesStream(
      String id);

  Stream<QuerySnapshot<Map<String, dynamic>>> getUnapprovedVenuesStream(
      String id);

  String generateUniqueId();
}
