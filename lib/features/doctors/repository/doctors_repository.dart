import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient/models/doctor.dart';

final doctorsRepositoryProvider = Provider(
  (ref) {
    return DoctorsRepository(FirebaseFirestore.instance, FirebaseAuth.instance);
  },
);

class DoctorsRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth _auth;

  DoctorsRepository(this.firestore, this._auth);

  Future<List<Doctor>> allDoctorsList() async {
    final List<Doctor> doctors = [];

    return doctors;
  }

  Stream<List<Doctor>> getDoctorsList() {
    return firestore.collection('doctors').snapshots().map(
      (event) {
        List<Doctor> doctors = [];
        for (var document in event.docs) {
          var doctor = document.data();
          doctors.add(Doctor.fromMap(doctor));
        }
        return doctors;
      },
    );
  }

  Future<List<Doctor>> getRegisteredDoctorsList() async {
    final uid = _auth.currentUser!.uid;
    final db = await firestore.collection('patients/$uid/regDoctors').get();
    List<Doctor> regDoctors = [];
    for (var document in db.docs) {
      var doctorData = document.data();
      Doctor doctor = Doctor(
        enrolled: doctorData['enrolled'],
        profilePic: doctorData['profilePic'],
        name: doctorData['name'],
        specialization: doctorData['spec'],
        uid: doctorData['uid'],
      );
      if (doctorData['isRegistered']) {
        regDoctors.add(doctor);
      }
    }
    return regDoctors;
  }
}
