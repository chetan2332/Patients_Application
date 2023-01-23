// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient/common/repository/common_firebase_storage.dart';
import 'package:patient/common/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient/features/authentication/screens/user_information_screen.dart';
import 'package:patient/models/pateient.dart';
import 'package:patient/features/doctors/screens/doctors_list_screen.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance),
);

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore firestore;

  AuthRepository(this._auth, this.firestore);

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.of(context)
          .pushReplacementNamed(UserInformationScreen.routeName);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, error: e.message!);
    }
  }

  void signOut() {
    _auth.signOut();
  }

  Future<void> loginWithEmail(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (_auth.currentUser!.emailVerified) {
        showSnackBar(context: context, error: 'email verification failed');
      }
      Navigator.of(context).pushNamed(DoctorsListScreen.routeName);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, error: e.message!);
    }
  }

  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = _auth.currentUser!.uid;
      String photoUrl =
          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';
      if (profilePic != null) {
        photoUrl =
            await ref.read(commonFirebaseRepositoryProvider).saveFileToFirebase(
                  'patients/profilePic/$uid',
                  profilePic,
                );
      }
      var user = Patient(
        name: name,
        uid: uid,
        profilePic: photoUrl,
        phoneNumber: '',
      );

      await firestore.collection('patients').doc(uid).set(user.toMap());

      Navigator.of(context).pushNamedAndRemoveUntil(
          DoctorsListScreen.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context: context, error: e.toString());
    }
  }

  void updateUserDataEveryWhere({
    required String name,
    required File? profilePic,
    required String photoUrl,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = _auth.currentUser!.uid;

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseRepositoryProvider)
            .saveFileToFirebase('patients/profilePic/$uid', profilePic);
      }

      var map = {
        'name': name,
        'profilePic': photoUrl,
      };

      await firestore
          .collection('patients')
          .doc(uid)
          .set(map, SetOptions(merge: true));

      List<String> doctorId = [];
      await firestore
          .collection('patients/$uid/regDoctors')
          .get()
          .then((value) {
        for (var document in value.docs) {
          doctorId.add(document.id);
        }
      });

      for (var id in doctorId) {
        await firestore
            .collection('doctors/$id/patients')
            .doc(uid)
            .set(map, SetOptions(merge: true));
      }
    } catch (e) {
      showSnackBar(context: context, error: e.toString());
    }
  }

  Future<Patient?> getCurrentUserData() async {
    Patient? userData;
    var data = await firestore
        .collection('patients')
        .doc(_auth.currentUser?.uid)
        .get();
    if (!data.exists || data.data() == null) {
      return null;
    }
    userData = Patient.fromMap(data.data()!);
    return userData;
  }
}
