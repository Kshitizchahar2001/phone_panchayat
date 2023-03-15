// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/add_post_screen/Media/ui/mediaTile.dart';
import 'package:online_panchayat_flutter/screens/add_post_screen/Media/data/mediaUploadData.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class MediaAttachment extends StatelessWidget {
  final MediaUploadData mediaUploadData;
  const MediaAttachment({
    Key key,
    @required this.mediaUploadData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: mediaUploadData.mediaAvailable,
      builder: (context, value, child) {
        return value
            ? RemovableWidget(
                child: MediaTile(
                  mediaUploadData: mediaUploadData,
                ),
                onRemoved: mediaUploadData.removeFile,
              )
            : Container();
      },
    );
  }
}
