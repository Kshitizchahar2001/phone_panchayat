// ignore_for_file: file_names, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:online_panchayat_flutter/enum/fileType.dart';
import 'package:online_panchayat_flutter/screens/add_post_screen/Media/ui/addMediaButton.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constants/constants.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'dart:io';
import '../addPostScreenData.dart';
import 'linkInformationWidget.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Divider(
            color: KThemeLightGrey,
            height: 1,
            indent: context.safePercentWidth * 4,
            endIndent: context.safePercentWidth * 4,
          ),
          Padding(
            padding: getPostWidgetSymmetricPadding(context, vertical: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LinkInformationWidget(),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AddMediaButton(
                      mediaButtonData:
                          getMediaButtonData[MediaButtonType.Image],
                      onPressed: () => getFile(FileType.Image, context),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    AddMediaButton(
                      mediaButtonData:
                          getMediaButtonData[MediaButtonType.Video],
                      onPressed: () => getFile(FileType.Video, context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future getFile(FileType fileType, BuildContext context) async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: ((builder) => BottomSheetWidget((file) async {
              if (file != null) {
                if (fileType == FileType.Image) {
                  CroppedFile croppedImage = await ImageCropper().cropImage(
                    sourcePath: file.path,
                  );
                  Provider.of<AddPostScreenData>(context, listen: false)
                      .insertImage(croppedImage as File);
                } else if (fileType == FileType.Video) {
                  File video = File(file.path);
                  Provider.of<AddPostScreenData>(context, listen: false)
                      .insertVideo(video);
                }
              } else {
                print('No file selected.');
              }
            }, fileType: fileType)));
  }
}
