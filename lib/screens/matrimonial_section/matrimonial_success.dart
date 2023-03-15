// ignore_for_file: annotate_overrides, prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/images.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/current_matrimonail_profile_data.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/shimmerEffects/rectangular_image.dart';
import 'package:online_panchayat_flutter/screens/referAndEarnScreen/referAndEarnData.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:io';
import 'dart:typed_data';

class MatrimonialShare extends StatefulWidget {
  const MatrimonialShare({Key key}) : super(key: key);

  @override
  State<MatrimonialShare> createState() => _MatrimonialShareState();
}

class _MatrimonialShareState extends State<MatrimonialShare> {
  CurrentMatrimonailProfileData _currentMatrimonailProfileData;
  ScreenshotController _screenShotController;

  void initState() {
    _currentMatrimonailProfileData =
        Provider.of<CurrentMatrimonailProfileData>(context, listen: false);
    _screenShotController = ScreenshotController();
    super.initState();
  }

  void showMatchesList() async {
    await _currentMatrimonailProfileData.fetchMatrimonailProfile();
    // context.vxNav.push(Uri.parse(MyRoutes.matchList), params: currentProfile);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void shareToSocialMedia() async {
    /// Event Log
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "matrimonial_success_share", parameters: {
      "user_id": Services.globalDataNotifier.localUser.id ?? "",
      "name": Services.globalDataNotifier.localUser.name ?? "",
      "state": Services.globalDataNotifier.localUser.state_id ?? ""
    });

    /// Capture the image and share to social media
    ///
    Uint8List image = await _screenShotController.capture(
        pixelRatio: 16 / 9, delay: Duration(milliseconds: 0));
    final directory = await getApplicationDocumentsDirectory();
    File imageFile = File('${directory.path}/poster.png');
    imageFile.writeAsBytesSync(image);
    String referLink = await ReferAndEarnData().getMyReferralLink();
    String shareMessage = MATRIMONIAL_SHARE_MESSAGE.tr() + "" + referLink;

    await Share.shareFiles([imageFile.path], text: shareMessage);
  }

  String get userImage {
    if (_currentMatrimonailProfileData.currentUserProfile != null &&
        _currentMatrimonailProfileData.currentUserProfile.images != null &&
        _currentMatrimonailProfileData.currentUserProfile.images.isNotEmpty) {
      return _currentMatrimonailProfileData.currentUserProfile.images[0];
    }
    return Services.globalDataNotifier.localUser.image ??
        DEFAULT_USER_IMAGE_URL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 2.0,
        iconTheme: IconThemeData(color: maroonColor),
        title: Text(
          SHARE,
          style: Theme.of(context).textTheme.headline2.copyWith(
              color: maroonColor,
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.m)),
        ).tr(),
      ),
      body: Screenshot(
        controller: _screenShotController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: context.safePercentHeight * 1,
                ),
                SizedBox(
                  height: context.safePercentHeight * 12,
                  width: context.safePercentWidth * 20,
                  child: CachedNetworkImage(
                    imageUrl: userImage,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) => Shimmer.fromColors(
                      child: CircleAvatar(backgroundColor: lightGreySubheading),
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(
                  height: context.safePercentHeight * 20,
                  child: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    imageUrl: matrimonial_share_image,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            RectangularImageLoading(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(
                  height: context.safePercentHeight * 2,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: maroonColor),
                  padding: EdgeInsets.symmetric(
                      vertical: context.safePercentHeight * 2,
                      horizontal: context.safePercentWidth * 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        CONGRATULATION,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.l),
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ).tr(),
                      SizedBox(
                        height: context.safePercentHeight * 0.7,
                      ),
                      Text(
                        PREMIUM_USER_MESSAGE,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.m),
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ).tr(),
                    ],
                  ),
                ),
                SizedBox(
                  height: context.safePercentHeight * 2,
                ),
              ],
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: maroonColor),
                    padding: EdgeInsets.symmetric(
                        horizontal: context.safePercentWidth * 4,
                        vertical: context.safePercentHeight * 2),
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          MATRIMONIAL_SUCCESS_MESSAGE,
                          style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.m),
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ).tr(),
                        SizedBox(
                          height: context.safePercentHeight * 4,
                        ),
                        SizedBox(
                          width: context.safePercentWidth * 35,
                          child: Center(
                            child: CustomButton(
                              boxBorder: Border.all(color: Colors.white),
                              text: SUBMIT,
                              buttonColor: maroonColor,
                              autoSize: true,
                              borderRadius: 15,
                              boxShadow: [BoxShadow()],
                              onPressed: showMatchesList,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: shareToSocialMedia,
                    child: Container(
                      height: context.safePercentHeight * 6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: lightGreySubheading.withOpacity(0.8)),
                      padding: EdgeInsets.symmetric(
                          vertical: context.safePercentHeight * 0.5,
                          horizontal: context.safePercentWidth * 6),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.screen_share_outlined,
                              size: 24,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: context.safePercentWidth * 1,
                            ),
                            Text(
                              SHARE_ON_SOCIAL_MEDIA,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                      fontSize: responsiveFontSize(context,
                                          size: ResponsiveFontSizes.s),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                            ).tr()
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
