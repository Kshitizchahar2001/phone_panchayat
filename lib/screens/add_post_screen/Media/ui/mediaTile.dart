// ignore_for_file: file_names, prefer_const_constructors, curly_braces_in_flow_control_structures, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/screens/add_post_screen/Media/data/imageData.dart';
import 'package:online_panchayat_flutter/screens/add_post_screen/Media/data/mediaUploadData.dart';
import 'package:online_panchayat_flutter/screens/add_post_screen/Media/data/videoData.dart';
import 'package:online_panchayat_flutter/screens/widgets/scaleTransitionAnimation.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

import 'attachedImage.dart';
import 'attachedVideo.dart';

class MediaTile extends StatelessWidget {
  final MediaUploadData mediaUploadData;
  const MediaTile({
    Key key,
    @required this.mediaUploadData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        for (int i = 0; i < shadows.length; i++)
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.4),
            offset: shadows[i],
            blurRadius: 4.0,
          )
      ]),
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mediaUploadData.isThumbnailImage
                    ? Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ScaleTransitionAnimation(
                          child: Icon(
                            FontAwesomeIcons.solidStar,
                            color: Color(0xFFFFC107),
                            size: 20.0,
                          ),
                        ),
                      )
                    : Container(),
                Flexible(
                  flex: 3,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: mediaUploadData.uploadInProgress,
                    builder: (context, value, child) {
                      return value
                          ? UploadInProgress(mediaUploadData: mediaUploadData)
                          : UploadComplete();
                    },
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: ValueListenableBuilder(
                    valueListenable: mediaUploadData.mediaAvailable,
                    builder: (context, value, child) {
                      if (mediaUploadData is ImageData)
                        return AttachedImage(
                          imageUploadData: mediaUploadData,
                          key: key,
                        );
                      else if (mediaUploadData is VideoData)
                        return AttachedVideo(
                          videoUploadData: mediaUploadData,
                          key: key,
                        );
                      else
                        return Container();
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 5,
            child: ValueListenableBuilder<double>(
              valueListenable: mediaUploadData.uploadProgress,
              builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FractionallySizedBox(
                          widthFactor: value / 100,
                          // widthFactor: .3,
                          child: Container(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class UploadInProgress extends StatelessWidget {
  final MediaUploadData mediaUploadData;
  const UploadInProgress({Key key, @required this.mediaUploadData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder<String>(
          valueListenable: mediaUploadData.ongoingTaskName,
          builder: (context, taskName, child) {
            return Text(
              taskName,
              style: Theme.of(context).textTheme.headline1.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: responsiveFontSize(context,
                        size: ResponsiveFontSizes.s),
                  ),
            );
          },
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ValueListenableBuilder(
              valueListenable: mediaUploadData.uploadProgress,
              builder: (context, value, child) {
                return Text(
                  "${value.toInt().toString()} %",
                  style: Theme.of(context).textTheme.headline3.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: responsiveFontSize(
                          context,
                          size: ResponsiveFontSizes.m10,
                        ),
                      ),
                );
              },
            ),
            SizedBox(
              width: 15,
            ),
            SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class UploadComplete extends StatelessWidget {
  const UploadComplete({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Text(
        "Upload complete",
        style: Theme.of(context).textTheme.headline1.copyWith(
              fontWeight: FontWeight.normal,
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.m),
            ),
      ),
      ScaleTransitionAnimation(child: DoneIcon())
    ]);
  }
}

class DoneIcon extends StatelessWidget {
  const DoneIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(
            Icons.done,
            size: 15,
            color: Colors.white,
          ),
        ));
  }
}
