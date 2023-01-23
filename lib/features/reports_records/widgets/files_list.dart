import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient/features/reports_records/controller/reports_records_controller.dart';
import 'package:patient/features/reports_records/widgets/files_list_item.dart';
import 'package:patient/models/doctor.dart';
import 'package:patient/models/report.dart';

class FilesList extends ConsumerStatefulWidget {
  final Doctor doctor;
  const FilesList(this.doctor, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilesListState();
}

class _FilesListState extends ConsumerState<FilesList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Report>>(
      stream: ref
          .watch(reportsRecordControllerProvider)
          .getAllFilesList(widget.doctor.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.data == null) {
          return const Center(
            child: Text('No reports found'),
          );
        }

        List<Report> reports = snapshot.data!;

        return ListView.builder(
          itemCount: reports.length,
          itemBuilder: (context, index) {
            return FilesListItem(report: reports[index]);
          },
        );
      },
    );
  }
}
