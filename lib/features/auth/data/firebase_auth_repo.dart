import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/features/auth/domain/repos/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> getCurrentUser() async {
    try {
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
        type: type!,
        isOnline: true,
        latitude: latitude ?? 0,
        longitude: longitude ?? 0,
      );
    } catch (e) {
      throw Exception('Login Failed $e');
    }
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

      //update email in firestore
      //incase user changed email, update the field
      await firebaseFirestore
          .collection('${userTypeToString(type!)}s')
          .doc(userCredential.user!.uid)
          .update(
        {'email': email},
      );

      //create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name ?? '',
        type: type,
        isOnline: true,
        latitude: latitude ?? 0,
        longitude: longitude ?? 0,
      );

      //make user online on login
      await firebaseFirestore
          .collection('${userTypeToString(type)}s')
          .doc(userCredential.user!.uid)
          .update(
        {'isOnline': true},
      );

      return user;
    } catch (e) {
      throw Exception('Login Failed $e');
    }
  }

  @override
  Future<void> logout(String id, UserType userType) async {
    //todo handle if user null
    //make user offline
    await firebaseFirestore
        .collection('${userTypeToString(userType)}s')
        .doc(id)
        .update(
      {'isOnline': false},
    );

    //logout user
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
    String name,
    String email,
    String password,
    double latitude,
    double longitude,
    UserType type,
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
        type: type,
        latitude: latitude,
        longitude: longitude,
        isOnline: true,
      );

      //save user data in firestore
      //if owner
      if (type == UserType.owner) {
        await firebaseFirestore
            .collection("owners")
            .doc(user.uid)
            .set(user.toJson());
      }
      //if user
      else if (type == UserType.user) {
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
  Future<UserType?> getUserType() async {
    //current user
    final firebaseUser = firebaseAuth.currentUser;

    //user doesn't exist
    if (firebaseUser == null) {
      return null;
    }

    final usersCollection = FirebaseFirestore.instance.collection('users');
    final ownersCollection = FirebaseFirestore.instance.collection('owners');
    final adminsCollection = FirebaseFirestore.instance.collection('admins');

    // Check if the document exists in the "users" collection
    final userDoc = await usersCollection.doc(firebaseUser.uid).get();

    if (userDoc.exists) {
      return UserType.user;
    }

    // Check if the document exists in the "owners" collection
    final ownerDoc = await ownersCollection.doc(firebaseUser.uid).get();

    if (ownerDoc.exists) {
      return UserType.owner;
    }

    // Check if the document exists in the "owners" collection
    final adminDoc = await adminsCollection.doc(firebaseUser.uid).get();

    if (adminDoc.exists) {
      return UserType.admin;
    }

    // If the document doesn't exist in either collection
    return null;
  }

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
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final ownersCollection = FirebaseFirestore.instance.collection('owners');
    final adminsCollection = FirebaseFirestore.instance.collection('admins');

    //check if the document exists in the "users" collection
    final userDoc = await usersCollection.doc(firebaseUser.uid).get();

    if (userDoc.exists) {
      return userDoc['name'];
    }

    //check if the document exists in the "owners" collection
    final ownerDoc = await ownersCollection.doc(firebaseUser.uid).get();

    if (ownerDoc.exists) {
      return ownerDoc['name'];
    }

    //check if the document exists in the "owners" collection
    final adminDoc = await adminsCollection.doc(firebaseUser.uid).get();

    if (adminDoc.exists) {
      return adminDoc['name'];
    }

    return '';
  }

  //get user latitude
  @override
  Future<double?> getCurrentUserLatitude(UserType? type) async {
    //current user
    final firebaseUser = firebaseAuth.currentUser;

    //user doesn't exist
    if (firebaseUser == null) {
      return 0;
    }

    if (type == null) {
      return 0;
    }

    //access users or owners
    final collection =
        FirebaseFirestore.instance.collection('${userTypeToString(type)}s');

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
  Future<double?> getCurrentUserLongitude(UserType? type) async {
    //current user
    final firebaseUser = firebaseAuth.currentUser;

    //user doesn't exist
    if (firebaseUser == null) {
      return 0;
    }

    if (type == null) {
      return 0;
    }

    //access users or owners
    final collection =
        FirebaseFirestore.instance.collection('${userTypeToString(type)}s');

    //get data fields as json
    final docSnapshot = await collection.doc(firebaseUser.uid).get();

    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data()!;

      return data['longitude'];
    }

    return 0;
  }
}
