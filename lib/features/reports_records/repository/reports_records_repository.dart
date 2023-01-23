import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:patient/common/repository/common_firebase_storage.dart';
import 'package:patient/common/utils/utils.dart';
import 'package:patient/models/doctor.dart';
import 'package:patient/models/report.dart';
import 'package:uuid/uuid.dart';

final reportsRecordRepositoryProvider = Provider(
  (ref) => ReportsRecordRepository(
    FirebaseAuth.instance,
    FirebaseFirestore.instance,
    ref.watch(commonFirebaseRepositoryProvider),
  ),
);

class ReportsRecordRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore firebase;
  final CommonFirebaseStorageRepository storageRepository;

  ReportsRecordRepository(this._auth, this.firebase, this.storageRepository);

  Future<void> uploadFile(BuildContext context, Doctor doctor, File file,
      ProviderRef ref, String fileName) async {
    final String fileId = const Uuid().v1();
    final String userId = _auth.currentUser!.uid;
    try {
      String url = await ref
          .read(commonFirebaseRepositoryProvider)
          .saveFileToFirebase('patients/reports/${doctor.uid}/$fileId', file);
      await firebase
          .collection('patients/$userId/regDoctors/${doctor.uid}/reports')
          .doc(fileId)
          .set(
            Report(
              url: url,
              fileName: fileName,
              timeOfUpload: DateTime.now(),
            ).toMap(),
          );
    } catch (e) {
      showSnackBar(context: context, error: e.toString());
    }
  }

  Stream<List<Report>> getAllFilesList(String doctorId) {
    final String userId = _auth.currentUser!.uid;
    return firebase
        .collection('patients/$userId/regDoctors/$doctorId/reports')
        .orderBy('timeOfUpload')
        .snapshots()
        .map(
      (event) {
        List<Report> reports = [];
        for (var document in event.docs) {
          var report = document.data();
          reports.add(Report.fromMap(report));
        }
        return reports;
      },
    );
  }

  Stream<List<String>> getReportsByMonth(
      String doctorUid, BuildContext context) {
    final String userId = _auth.currentUser!.uid;
    return firebase
        .collection('patients/$userId/regDoctors/$doctorUid/reports/byMonth')
        .snapshots()
        .map((event) {
      List<String> allReports = [];
      for (var document in event.docs) {
        allReports.add(document.id);
      }
      print(allReports);
      return allReports;
    });
  }

  Future<void> uploadReport(String doctorUid, File file, String fileName,
      String category, BuildContext context) async {
    final String fileId = const Uuid().v1();
    final String userId = _auth.currentUser!.uid;

    try {
      String url = await storageRepository.saveFileToFirebase(
          'patients/reports/$doctorUid/$fileId', file);
      final month = DateFormat.yM().format(DateTime.now());
      await firebase
          .collection(
              'patients/$userId/regDoctors/$doctorUid/reports/byMonth/$month')
          .doc(category)
          .set(
            Report(
              url: url,
              fileName: fileName,
              timeOfUpload: DateTime.now(),
            ).toMap(),
          );
      await firebase
          .collection(
              'patients/$userId/regDoctors/$doctorUid/reports/byCategory/$category')
          .doc(fileId)
          .set(
            Report(
              url: url,
              fileName: fileName,
              timeOfUpload: DateTime.now(),
            ).toMap(),
          );
    } catch (e) {
      showSnackBar(context: context, error: e.toString());
    }
  }
}
