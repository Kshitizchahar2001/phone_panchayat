// ignore_for_file: file_names, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/add_post_screen/Media/data/mediaUploadData.dart';
import 'package:online_panchayat_flutter/screens/add_post_screen/Media/ui/attachedMedia.dart';

class AttachedImage extends AttachedMedia {
  final MediaUploadData imageUploadData;
  AttachedImage({
    Key key,
    @required this.imageUploadData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Image(
        fit: BoxFit.fitHeight,
        image: (imageUploadData.url != null)
            ? Image.network(imageUploadData.url).image
            : Image.file(imageUploadData.pickedFile).image,
      ),
    );
  }
}
