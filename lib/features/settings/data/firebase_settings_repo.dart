import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/features/settings/domain/settings_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseSettingsRepo implements SettingsRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //update user name
  @override
  Future<String?> updateUserName(String newName) async {
    //current user
    final firebaseUser = firebaseAuth.currentUser;

    //user doesn't exist
    if (firebaseUser == null) {
      return '';
    }

    //access users, owners, and admins collections
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final ownersCollection = FirebaseFirestore.instance.collection('owners');
    final adminsCollection = FirebaseFirestore.instance.collection('admins');

    //check if the document exists in the "users" collection
    final userDoc = await usersCollection.doc(firebaseUser.uid).get();

    if (userDoc.exists) {
      await usersCollection.doc(firebaseUser.uid).update({'name': newName});

      return newName;
    }

    //check if the document exists in the "owners" collection
    final ownerDoc = await ownersCollection.doc(firebaseUser.uid).get();

    if (ownerDoc.exists) {
      await ownersCollection.doc(firebaseUser.uid).update({'name': newName});

      return newName;
    }

    //check if the document exists in the "admins" collection
    final adminDoc = await adminsCollection.doc(firebaseUser.uid).get();

    if (adminDoc.exists) {
      await adminsCollection.doc(firebaseUser.uid).update({'name': newName});

      return newName;
    }
    return '';
  }

  //update user type
  @override
  Future<UserType?> updateUserType(UserType initType, UserType newType) async {
    final firebaseUser = firebaseAuth.currentUser;

    //user doesn't exist
    if (firebaseUser == null) {
      return initType;
    }

    //access users, owners, and admins collections
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final ownersCollection = FirebaseFirestore.instance.collection('owners');
    final adminsCollection = FirebaseFirestore.instance.collection('admins');

    //determine the current collection
    final CollectionReference currentCollection;

    if (initType == UserType.user) {
      currentCollection = usersCollection;
    } else if (initType == UserType.owner) {
      currentCollection = ownersCollection;
    } else {
      currentCollection = adminsCollection;
    }

    //check if the document exists in the current collection
    final userDoc = await currentCollection.doc(firebaseUser.uid).get();

    if (userDoc.exists) {
      final newCollection;

      //copy the document to the new collection
      if (newType == UserType.user) {
        newCollection = usersCollection;
      } else if (newType == UserType.owner) {
        newCollection = ownersCollection;
      } else {
        newCollection = adminsCollection;
      }

      await newCollection.doc(firebaseUser.uid).set(userDoc.data());
      //update type field
      await newCollection.doc(firebaseUser.uid).update({'type': newType.name});

      // delete the document from the old collection
      await currentCollection.doc(firebaseUser.uid).delete();

      return newType;
    }

    return initType;
  }

  //update user email
  @override
  Future<String?> updateUserEmail(String newEmail, String oldEmail) async {
    final firebaseUser = firebaseAuth.currentUser;

    //user doesn't exist
    if (firebaseUser == null) {
      return oldEmail;
    }

    try {
      //update email
      await firebaseUser.verifyBeforeUpdateEmail(newEmail);

      //success
      return newEmail;
    } catch (e) {
      //error
      if (e is FirebaseAuthException) {
        return e.message ?? "An authentication error occurred.";
      }
      return oldEmail;
    }
  }
}
