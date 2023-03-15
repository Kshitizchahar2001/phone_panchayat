// ignore_for_file: file_names, avoid_print, avoid_print, duplicate_ignore

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:online_panchayat_flutter/services/services.dart';

abstract class MediaUploadData {
  File pickedFile;
  bool isThumbnailImage = false;
  // ValueNotifier<File> pickedFile;
  ValueNotifier<double> uploadProgress;
  ValueNotifier<bool> uploadInProgress;
  ValueNotifier<bool> mediaAvailable;
  String url;
  UploadTask uploadTask;

  ValueNotifier<String> ongoingTaskName;

  MediaUploadData() {
    uploadInProgress = ValueNotifier(false);
    mediaAvailable = ValueNotifier(false);
    uploadProgress = ValueNotifier(0.0);
    ongoingTaskName = ValueNotifier("Uploading");
  }

  uploadTaskEventListener(TaskSnapshot event) {
    uploadProgress.value =
        (event.bytesTransferred.toDouble() / event.totalBytes.toDouble()) * 100;
  }

  removeFile() {
    if (uploadInProgress.value) uploadTask?.cancel();

    url = null;
    mediaAvailable.value = false;
    pickedFile = null;
    uploadInProgress.value = false;
    cancelCompression();
  }

  void cancelCompression();

  setPickedFile(
    File file, {
    bool showMedia = true,
  }) async {
    if (mediaAvailable.value) removeFile();
    pickedFile = file;
    mediaAvailable.value = showMedia;

    uploadInProgress.value = true;
    try {
      await uploadToStorage(Services.globalDataNotifier.localUser.id)
          .then((value) => url = value);
    } catch (e) {
      print('upload canceled');
    }
    uploadInProgress.value = false;
  }

  Future<String> uploadToStorage(String userId);
}
