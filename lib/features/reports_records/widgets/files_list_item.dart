import 'package:flutter/material.dart';
import 'package:patient/models/report.dart';

class FilesListItem extends StatelessWidget {
  final Report report;
  const FilesListItem({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(report.fileName),
    );
  }
}
