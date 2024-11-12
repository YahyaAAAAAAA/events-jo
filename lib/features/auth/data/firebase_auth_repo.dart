import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/auth/domain/repos/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> getCurrentUser() async {
    //get current user
    final firebaseUser = firebaseAuth.currentUser;

    //fetch user's name
    final name = await getCurrentUserName();

    //fetch user's type
    final type = await getUserType();

    //fetch user's latitude
    final latitude = await getCurrentUserLatitude(type);

    //fetch user's longitude
    final longitude = await getCurrentUserLongitude(type);

    //no user logged in
    if (firebaseUser == null) {
      return null;
    }

    //user exists
    return AppUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
      name: name ?? '',
      type: type ?? '',
      latitude: latitude ?? 0,
      longitude: longitude ?? 0,
    );
  }

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      //attempt sign in
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      //fetch user's name
      final name = await getCurrentUserName();

      //fetch user's type
      final type = await getUserType();

      //fetch user's latitude
      final latitude = await getCurrentUserLatitude(type);

      //fetch user's longitude
      final longitude = await getCurrentUserLongitude(type);

      //create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name ?? '',
        type: type ?? '',
        latitude: latitude ?? 0,
        longitude: longitude ?? 0,
      );
      return user;
    } catch (e) {
      throw Exception('Login Failed $e');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
    String name,
    String email,
    String password,
    double latitude,
    double longitude,
    bool isOwner,
  ) async {
    try {
      //attempt sign up
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      //create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
        type: isOwner ? 'owner' : 'user',
        latitude: latitude,
        longitude: longitude,
      );

      //save user data in firestore
      if (isOwner) {
        await firebaseFirestore
            .collection("owners")
            .doc(user.uid)
            .set(user.toJson());
      } else {
        await firebaseFirestore
            .collection("users")
            .doc(user.uid)
            .set(user.toJson());
      }

      return user;
    } catch (e) {
      throw Exception('Register Failed $e');
    }
  }

  //get user type
  @override
  Future<String?> getUserType() async {
    //current user
    final firebaseUser = firebaseAuth.currentUser;

    //user doesn't exist
    if (firebaseUser == null) {
      return '';
    }

    final usersCollection = FirebaseFirestore.instance.collection('users');
    final ownersCollection = FirebaseFirestore.instance.collection('owners');

    // Check if the document exists in the "users" collection
    final userDoc = await usersCollection.doc(firebaseUser.uid).get();

    if (userDoc.exists) {
      return 'user';
    }

    // Check if the document exists in the "owners" collection
    final ownerDoc = await ownersCollection.doc(firebaseUser.uid).get();

    if (ownerDoc.exists) {
      return 'owner';
    }

    // If the document doesn't exist in either collection
    return '';
  }

  //the following methods are helper methods
  //their returns saved in the current user object with every login

  //get user name
  @override
  Future<String?> getCurrentUserName() async {
    //current user
    final firebaseUser = firebaseAuth.currentUser;

    //user doesn't exist
    if (firebaseUser == null) {
      return '';
    }

    //access users
    final collection = FirebaseFirestore.instance.collection('users');

    //get data fields as json
    final docSnapshot = await collection.doc(firebaseUser.uid).get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;

      return data['name'];
    }

    return '';
  }

  //get user latitude
  @override
  Future<double?> getCurrentUserLatitude(String? type) async {
    //current user
    final firebaseUser = firebaseAuth.currentUser;

    //user doesn't exist
    if (firebaseUser == null) {
      return 0;
    }

    if (type!.isEmpty) {
      return 0;
    }

    //access users or owners
    final collection = FirebaseFirestore.instance.collection('${type}s');

    //get data fields as json
    final docSnapshot = await collection.doc(firebaseUser.uid).get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;

      return data['latitude'];
    }

    return 0;
  }

  //get user longitude
  @override
  Future<double?> getCurrentUserLongitude(String? type) async {
    //current user
    final firebaseUser = firebaseAuth.currentUser;

    //user doesn't exist
    if (firebaseUser == null) {
      return 0;
    }

    if (type!.isEmpty) {
      return 0;
    }

    //access users or owners
    final collection = FirebaseFirestore.instance.collection('${type}s');

    //get data fields as json
    final docSnapshot = await collection.doc(firebaseUser.uid).get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;

      return data['longitude'];
    }

    return 0;
  }
}
