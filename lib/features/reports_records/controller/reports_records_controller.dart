import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient/features/reports_records/repository/reports_records_repository.dart';
import 'package:patient/models/doctor.dart';
import 'package:patient/models/report.dart';

final reportsRecordControllerProvider = Provider((ref) {
  final reportsRepository = ref.watch(reportsRecordRepositoryProvider);
  return ReportsRecordController(ref, reportsRepository);
});

class ReportsRecordController {
  final ProviderRef ref;
  final ReportsRecordRepository reportsRepository;

  ReportsRecordController(this.ref, this.reportsRepository);

  Future<void> uploadFile(BuildContext context, Doctor doctor, File file,
      String fileName, String category) {
    return reportsRepository.uploadReport(
        doctor.uid, file, fileName, category, context);
  }

  Stream<List<Report>> getAllFilesList(String doctorId) {
    return reportsRepository.getAllFilesList(doctorId);
  }
}
