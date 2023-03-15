// ignore_for_file: file_names, annotate_overrides

import 'package:online_panchayat_flutter/services/storageService.dart';
import 'mediaUploadData.dart';

class ImageData extends MediaUploadData {
  ImageData();

  @override
  Future<String> uploadToStorage(String userId) async {
    uploadTask = StorageService().getPostImageUploadTask(
      image: pickedFile,
      userId: userId,
    );

    return StorageService().uploadPostImageAndGetUrl(
      eventListener: uploadTaskEventListener,
      uploadTask: uploadTask,
    );
  }

  void cancelCompression() {}
}
