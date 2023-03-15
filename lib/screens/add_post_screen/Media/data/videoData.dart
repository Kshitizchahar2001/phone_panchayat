// ignore_for_file: file_names, curly_braces_in_flow_control_structures, annotate_overrides

import 'package:online_panchayat_flutter/screens/add_post_screen/Media/data/mediaUploadData.dart';
import 'package:online_panchayat_flutter/services/storageService.dart';
import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';

class VideoData extends MediaUploadData {
  MediaUploadData imageUploadData;
  VideoData({@required this.imageUploadData});
  @override
  Future<String> uploadToStorage(String userId) async {
    Subscription _subscription;
    ongoingTaskName.value = 'Compressing Video';

    _subscription = VideoCompress.compressProgress$.subscribe((progress) {
      uploadProgress.value = progress;
    });

    if (imageUploadData.mediaAvailable.value == false)
      attachThumbnail(pickedFile.path);

    MediaInfo mediaInfo = await VideoCompress.compressVideo(pickedFile.path,
        quality: VideoQuality.LowQuality);

    _subscription.unsubscribe();

    uploadTask = StorageService().getVideoPostUploadTask(
      mediaInfo: mediaInfo,
      userId: userId,
    );

    ongoingTaskName.value = 'Uploading';

    return await StorageService().uploadPostVideoAndGetUrl(
      eventListener: uploadTaskEventListener,
      uploadTask: uploadTask,
    );
  }

  void attachThumbnail(String path) async {
    final thumbnailFile =
        await VideoCompress.getFileThumbnail(path, quality: 100, position: -1);
    imageUploadData.setPickedFile(thumbnailFile, showMedia: false);
  }

  void cancelCompression() {
    VideoCompress?.cancelCompression();
  }
}
