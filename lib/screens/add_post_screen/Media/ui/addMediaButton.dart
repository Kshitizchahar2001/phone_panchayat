// ignore_for_file: file_names, constant_identifier_names, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';

enum MediaButtonType { Image, Video }

Map<MediaButtonType, MediaButtonData> getMediaButtonData = {
  MediaButtonType.Image: MediaButtonData(
    iconColor: Color(0xffF6844D),
    iconData: Icons.image,
    title: PHOTO,
    // title: ADD_PHOTO,
  ),
  MediaButtonType.Video: MediaButtonData(
      iconColor: Color(0xffA37ADA),
      iconData: Icons.video_library,
      title: VIDEO),
};

class MediaButtonData {
  final String title;
  final IconData iconData;
  final Color iconColor;
  MediaButtonData({this.iconData, this.title, this.iconColor});
}

class AddMediaButton extends StatelessWidget {
  final MediaButtonData mediaButtonData;
  final Function onPressed;

  AddMediaButton({@required this.mediaButtonData, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onPressed,
          child: Column(
            children: [
              Icon(
                mediaButtonData.iconData,
                color: mediaButtonData.iconColor,
                size: 30,
                // size: context.safePercentHeight * 5,
              ),
              SizedBox(
                height: 3,
                // height: context.safePercentHeight * 0.8,
              ),
              Text(mediaButtonData.title.tr(),
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.xs),
                      )),
            ],
          ),
        ),
      ],
    );
  }
}
