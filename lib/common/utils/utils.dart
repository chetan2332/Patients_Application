import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar({required BuildContext context, required String error}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(error),
    ),
  );
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final XFile? img =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img == null) {
      return null;
    }
    image = File(img.path);
  } catch (err) {
    showSnackBar(context: context, error: err.toString());
  }
  return image;
}

Future<File?> pickPDForImage() async {
  File? file;
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'jpg', 'png'],
  );
  if (result != null) {
    file = File(result.files.single.path!);
  }
  return file;
}
