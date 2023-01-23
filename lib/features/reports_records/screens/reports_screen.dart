// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patient/colors.dart';
import 'package:patient/common/utils/colors.dart';
import 'package:patient/common/utils/utils.dart';
import 'package:patient/features/reports_records/controller/reports_records_controller.dart';
import 'package:patient/features/reports_records/widgets/fab.dart';
import 'package:patient/features/reports_records/widgets/files_list.dart';
import 'package:patient/features/reports_records/widgets/reports/reports.dart';
import 'package:patient/models/doctor.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  static const String routeName = '/report-screen';
  final Doctor doctor;
  const ReportsScreen({super.key, required this.doctor});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  bool isOpen = false;
  final _fileName =
      TextEditingController.fromValue(const TextEditingValue(text: 'New_File'));

  @override
  void dispose() {
    _fileName.dispose();
    super.dispose();
  }

  void open() {
    isOpen = true;
    setState(() {});
  }

  void close() {
    isOpen = false;
    setState(() {});
  }

  void uploadFile() async {
    File? file = await pickPDForImage();
    if (file == null) {
      return;
    } else {
      bool isUploaded = false;
      bool isLoading = false;
      _displayTextInputDialog(context).then((value) {
        if (!isUploaded) {
          isLoading = true;
          _startLoading();
        }
      });
      await ref.read(reportsRecordControllerProvider).uploadFile(
          context, widget.doctor, file, 'new file', 'Prescribtions');
      isUploaded = true;
      if (isLoading && isUploaded) {
        isLoading = false;
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('TextField in Dialog'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.done))
            ],
            content: TextField(
              onChanged: (value) {},
              controller: _fileName,
              decoration: const InputDecoration(hintText: "Enter File Name"),
            ),
          );
        });
  }

  Future<void> _startLoading() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const AlertDialog(
            title: Text('Please wait for a while...'),
            content: SizedBox(
                height: 100, child: Center(child: CircularProgressIndicator())),
          ),
        );
      },
    );
  }

  // Future<void> _displayTextInputDialog(BuildContext context) async {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Fab(open: open, close: close),
      backgroundColor: isOpen ? Colors.grey[700] : backgroundColor,
      body: Reports(widget.doctor.uid),
    );
  }
}
