import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/features/settings/domain/settings_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:latlong2/latlong.dart';

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

      await updateVenuesOwnerName(firebaseUser.uid, newName);

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

  //update user location
  @override
  Future<LatLng?> updateUserLocation(
    double initLat,
    double initLong,
    double newLat,
    double newLong,
  ) async {
    //current user
    final firebaseUser = firebaseAuth.currentUser;
    //current location
    final LatLng currnetLocation = LatLng(initLat, initLong);

    final LatLng newLocation = LatLng(newLat, newLong);

    //user doesn't exist
    if (firebaseUser == null) {
      return currnetLocation;
    }

    //access users, owners, and admins collections
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final ownersCollection = FirebaseFirestore.instance.collection('owners');
    final adminsCollection = FirebaseFirestore.instance.collection('admins');

    //check if the document exists in the "users" collection
    final userDoc = await usersCollection.doc(firebaseUser.uid).get();

    if (userDoc.exists) {
      //update lat
      await usersCollection.doc(firebaseUser.uid).update(
        {
          'latitude': newLocation.latitude,
        },
      );

      //update long
      await usersCollection.doc(firebaseUser.uid).update(
        {
          'longitude': newLocation.longitude,
        },
      );
      return newLocation;
    }

    //check if the document exists in the "owners" collection
    final ownerDoc = await ownersCollection.doc(firebaseUser.uid).get();

    if (ownerDoc.exists) {
      //update lat
      await ownersCollection.doc(firebaseUser.uid).update(
        {
          'latitude': newLocation.latitude,
        },
      );

      //update long
      await ownersCollection.doc(firebaseUser.uid).update(
        {
          'longitude': newLocation.longitude,
        },
      );

      return newLocation;
    }

    //check if the document exists in the "admins" collection
    final adminDoc = await adminsCollection.doc(firebaseUser.uid).get();

    if (adminDoc.exists) {
      //update lat
      await adminsCollection.doc(firebaseUser.uid).update(
        {
          'latitude': newLocation.latitude,
        },
      );

      //update long
      await adminsCollection.doc(firebaseUser.uid).update(
        {
          'longitude': newLocation.longitude,
        },
      );

      return newLocation;
    }

    //error
    return currnetLocation;
  }

  //update user email
  @override
  Future<String?> updateUserEmail(
    String newEmail,
    String oldEmail,
    String password,
  ) async {
    try {
      final firebaseUser = firebaseAuth.currentUser;

      //user doesn't exist
      if (firebaseUser == null) {
        throw FirebaseAuthException(
          code: 'user-not-logged-in',
          message: 'No user is currently logged in.',
        );
      }

      //reauthenticate the user
      final cred = EmailAuthProvider.credential(
        email: firebaseUser.email!,
        password: password,
      );

      await firebaseUser.reauthenticateWithCredential(cred);

      //update email
      await firebaseUser.verifyBeforeUpdateEmail(newEmail);

      //success
      return newEmail;
    } on FirebaseAuthException catch (e) {
      //re-throw to handle it in the calling function
      throw e;
    }
  }

  //update user password
  @override
  Future<String?> updateUserPassword(
      String newPassword, String oldPassword) async {
    try {
      final firebaseUser = firebaseAuth.currentUser;

      //user doesn't exist
      if (firebaseUser == null) {
        throw FirebaseAuthException(
          code: 'user-not-logged-in',
          message: 'No user is currently logged in.',
        );
      }

      //reauthenticate the user
      final cred = EmailAuthProvider.credential(
        email: firebaseUser.email!,
        password: oldPassword,
      );

      await firebaseUser.reauthenticateWithCredential(cred);

      //update password
      await firebaseUser.updatePassword(newPassword);

      //success
      return newPassword;
    } on FirebaseAuthException catch (e) {
      //re-throw to handle it in the calling function
      throw e;
    }
  }

  //update venues ownerName on owner name change
  @override
  Future<void> updateVenuesOwnerName(String id, String newName) async {
    //get a reference to the 'venues' collection
    final venuesCollection = FirebaseFirestore.instance.collection('venues');

    try {
      //fetch all documents in the 'venues' collection
      QuerySnapshot querySnapshot =
          await venuesCollection.where('ownerId', isEqualTo: id).get();

      //iterate through each document
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        //update the 'ownerName' field for the current document
        await doc.reference.update({'ownerName': newName});
      }
    } catch (e) {
      throw e;
    }
  }

  //todo this should be extended for farms and courts
}
