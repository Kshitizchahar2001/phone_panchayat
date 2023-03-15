// ignore_for_file: file_names, prefer_final_fields, avoid_print, await_only_futures

import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:video_compress/video_compress.dart';

class StorageService {
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadProfilePicAndGetUrl(
      {@required File image, @required String userId}) async {
    try {
      String url = await _firebaseStorage
          .ref(PROFILE_PIC_STORAGE_BUCKET_NAME)
          .child(userId + '.jpg')
          .putFile(image)
          .then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
      return url;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      print(e);
      return null;
    }
  }

  Future<String> uploadMatrimonailProfileImage({
    @required File image,
    @required String imageName,
  }) async {
    try {
      String url = await _firebaseStorage
          .ref(MATRIMONAIL_IMAGES_BUCKET_NAME)
          .child(imageName + '.jpg')
          .putFile(image)
          .then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
      return url;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      print(e);
      return null;
    }
  }

  UploadTask getPostImageUploadTask(
      {@required File image, @required String userId}) {
    return _firebaseStorage
        .ref(POST_IMAGE_STORAGE_BUCKET_NAME)
        .child('${userId}_${DateTime.now().toString()}.jpg')
        .putFile(image);
  }

  Future<String> uploadPostImageAndGetUrl({
    @required Function eventListener,
    @required UploadTask uploadTask,
  }) async {
    try {
      uploadTask.snapshotEvents.listen(eventListener).onError((error) {
        // do something to handle error
      });

      String url = await uploadTask
          .then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
      return url;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      print(e);
      return null;
    }
  }

  UploadTask getVideoPostUploadTask({
    @required MediaInfo mediaInfo,
    @required String userId,
  }) {
    print('File is at ${mediaInfo.path}');
    UploadTask task = _firebaseStorage
        .ref(POST_VIDEO_STORAGE_BUCKET_NAME)
        .child('${userId}_${DateTime.now().toString()}.mp4')
        .putFile(mediaInfo.file);
    return task;
  }

  Future<String> uploadPostVideoAndGetUrl({
    @required Function eventListener,
    @required UploadTask uploadTask,
  }) async {
    try {
      uploadTask.snapshotEvents.listen(eventListener).onError((error) {
        // do something to handle error
      });
      String url = await uploadTask
          .then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
      VideoCompress.deleteAllCache();
      return url;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      print(e);
      return null;
    }
  }

  Future<String> uploadAadhaarImageAndGetUrl(
      {@required File image, @required String userId}) async {
    try {
      String url = await _firebaseStorage
          .ref(AADHAAR_IMAGE_STORAGE_BUCKET_NAME)
          .child('$userId.jpg')
          .putFile(image)
          .then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
      return url;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      print(e);
      return null;
    }
  }

  Future<String> uploadProfessionalImageAndGetUrl(
      {@required File image, @required String userId}) async {
    try {
      String url = await _firebaseStorage
          .ref('professionalImageUploads')
          .child('$userId.jpg')
          .putFile(image)
          .then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
      return url;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      print(e);
      return null;
    }
  }

  Future<String> uploadCommentImageAndGetUrl(
      {@required File image, @required String userId}) async {
    try {
      String url = await _firebaseStorage
          .ref('commentImageUploads')
          .child('${userId}_${DateTime.now().toString()}.jpg')
          .putFile(image)
          .then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
      return url;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      print(e);
      return null;
    }
  }

  // Adding new method to upload Work images of Professionals
  Future<String> uploadWorkImages(
      {@required File image,
      @required String userId,
      @required int imageIndex}) async {
    try {
      String url = await _firebaseStorage
          .ref(WORK_IMAGES_STORAGE_BUCKET_NAME)
          .child(userId + "-$imageIndex" + '.jpg')
          .putFile(image)
          .then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
      return url;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      print(e);
      return null;
    }
  }

  /// Delete matrimonial Profile images
  Future<void> deleteMatrimonialImage({@required String url}) async {
    try {
      Reference imageRef = await _firebaseStorage.refFromURL(url);
      imageRef.delete();
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }
}
