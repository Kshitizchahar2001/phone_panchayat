// ignore_for_file: annotate_overrides, prefer_const_constructors, deprecated_member_use

import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/images.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/referAndEarnScreen/referAndEarnData.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:screenshot/screenshot.dart';

class ShareAdditionalTehsilPoster extends StatefulWidget {
  const ShareAdditionalTehsilPoster({Key key}) : super(key: key);

  @override
  State<ShareAdditionalTehsilPoster> createState() =>
      _ShareAdditionalTehsilPosterState();
}

class _ShareAdditionalTehsilPosterState
    extends State<ShareAdditionalTehsilPoster> {
  ScreenshotController _screenShotController;

  void initState() {
    _screenShotController = ScreenshotController();

    super.initState();
  }

  /// Method to share files on social media
  void shareToSocialMedia() async {
    /// Event Log
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "additional_tehsil_poster_share", parameters: {
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
    String shareMessage = POSTER_SHARE_MESSAGE.tr() + "" + referLink;

    await Share.shareFiles([imageFile.path], text: shareMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2.0,
        iconTheme: IconThemeData(color: maroonColor),
        title: Text(
          SHARE_ON_SOCIAL_MEDIA,
          style: Theme.of(context).textTheme.headline2.copyWith(
              color: maroonColor,
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.m)),
        ).tr(),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Screenshot(
        controller: _screenShotController,
        child: Container(
          color: Theme.of(context).cardColor,
          child: SharePoster(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: context.safePercentWidth * 55,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          elevation: 5.0,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: context.safePercentHeight * 0.3,
                horizontal: context.safePercentWidth * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  SHARE,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.m),
                      color: maroonColor,
                      fontWeight: FontWeight.w600),
                ).tr(),
                SizedBox(width: context.safePercentWidth * 1.5),
                Icon(
                  Icons.share_rounded,
                  color: maroonColor,
                  size:
                      responsiveFontSize(context, size: ResponsiveFontSizes.m),
                ),
              ],
            ),
          ),
          onPressed: shareToSocialMedia,
        ),
      ),
    );
  }
}

class SharePoster extends StatelessWidget {
  const SharePoster({
    Key key,
  }) : super(key: key);

  final String gifLink =
      "https://firebasestorage.googleapis.com/v0/b/phone-p-312802.appspot.com/o/NetworkAssets%2Ftest.gif?alt=media&token=7fd60e2a-e0ce-48b8-bb78-dc1c47635cac";

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipPath(
          clipper: OvalTopBorderClipper(),
          child: Container(
            color: maroonColor,
            height: context.safePercentHeight * 50,
            child: Padding(
              padding: EdgeInsets.only(top: context.safePercentHeight * 11),
              child: Column(
                children: [
                  Icon(
                    Icons.workspace_premium_rounded,
                    size: context.safePercentHeight * 7,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: context.safePercentHeight * 3,
                  ),
                  Divider(
                    color: Colors.white,
                    height: context.safePercentHeight * 0.4,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: context.safePercentHeight * 1.5,
                        horizontal: context.safePercentWidth * 4),
                    child: Text(
                      "${IAM.tr()} ${Services.globalDataNotifier.localUser.name ?? ""} ${SHARE_POSTER_CONTENT.tr()}",
                      // "Ab aap ban gye hai phone panchayat ke premium user, Ab aap dekh sakte h kisi bhi tehsil ki news",
                      style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.m),
                          color: Colors.white),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    height: context.safePercentHeight * 0.4,
                  ),
                  SizedBox(
                    height: context.safePercentHeight * 3,
                  ),
                  Text(
                    "Powered By Phone Panchayat",
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s),
                        color: Colors.white,
                        fontStyle: FontStyle.italic),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  height: context.safePercentHeight * 15,
                  width: context.safePercentWidth * 20,
                  child: Image.asset(phone_panchayat_icon)),
              // SizedBox(height: context.safePercentHeight * 0.7),
              Text(
                CONGRATULATION,
                style: Theme.of(context).textTheme.headline1.copyWith(
                    fontSize: responsiveFontSize(context,
                        size: ResponsiveFontSizes.l),
                    fontWeight: FontWeight.bold,
                    color: maroonColor),
              ).tr(),
              SizedBox(height: context.safePercentHeight * 0.2),
              Text(
                Services.globalDataNotifier.localUser.name,
                style: Theme.of(context).textTheme.headline1.copyWith(
                    fontSize: responsiveFontSize(context,
                        size: ResponsiveFontSizes.m),
                    fontWeight: FontWeight.bold,
                    color: maroonColor),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(gifLink), fit: BoxFit.scaleDown)),
          child: Padding(
            padding: EdgeInsets.only(bottom: context.safePercentHeight * 32),
            child: SizedBox(
              height: context.safePercentHeight * 35,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    share_poster_user_background,
                  ),
                  CircleAvatar(
                    radius: context.safePercentHeight * 9.1,
                    backgroundImage: NetworkImage(
                        Services.globalDataNotifier.localUser.image),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OvalTopBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, 40);
    path.quadraticBezierTo(size.width / 4, 0, size.width / 2, 0);
    path.quadraticBezierTo(size.width - size.width / 4, 0, size.width, 40);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
