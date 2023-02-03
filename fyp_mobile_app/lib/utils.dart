import 'package:flutter/material.dart';

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:fyp_mobile_app/services/auth_service.dart';
import 'package:permission_handler/permission_handler.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

Future<List<File>> pickImages({required BuildContext context}) async {
  List<File> images = [];
  AuthService authService = AuthService();
  try {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      openAppSettings();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    } else if (status.isGranted) {
      var files = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (files != null && files.files.isNotEmpty) {
        for (int i = 0; i < files.files.length; i++) {
          images.add(File(files.files[i].path!));
        }
      }
      // authService.addPic(context: context, image: images[0]);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
