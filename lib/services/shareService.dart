// ignore_for_file: file_names, prefer_final_fields

import 'dart:math';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/enum/shareMethod.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/remoteConfigService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:share/share.dart';

class ShareService {
  static FlutterShareMe flutterShareMe = FlutterShareMe();
  static AnalyticsService _analyticsService = AnalyticsService();

  String baseUrl = "https://phonepanchayat.com";

  static String getPostShareMessage({
    @required String postContent,
    @required var completeUrl,
  }) {
    try {
      return postContent.substring(0, min(postContent.length, 120)) +
          '\n$completeUrl' +
          '\n\nअपने क्षेत्र की खबरे पाते रहने के लिए डाउनलोड कीजिये फ़ोन पंचायत ऐप';
    } catch (e, s) {
      FirebaseCrashlytics.instance
          .recordError("Error generating post share message : " + e, s);
      return 'अपने क्षेत्र की खबरे पाते रहने के लिए डाउनलोड कीजिये फ़ोन पंचायत ऐप \n${RemoteConfigService.playStoreLink}';
    }
  }

  Future<void> shareWithOptions({
    @required String postId,
    @required var completeUrl,
    @required String postContent,
  }) async {
    _analyticsService.registerLinkShareEvent(
      postId: postId.toString(),
    );
    try {
      await Share.share(ShareService.getPostShareMessage(
          postContent: postContent, completeUrl: completeUrl));
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(
          "Error sharing post with share options : " + e.toString(), s);
    }
  }

  Future<void> shareOnSocialMedia({
    @required String postId,
    @required var completeUrl,
    @required String postContent,
    @required ShareMethod shareMethod,
  }) async {
    String response;
    _analyticsService.registerLinkShareEvent(
      postId: postId.toString(),
      method: shareMethod.toString().split('.').last.toString(),
    );

    completeUrl = (completeUrl as String) +
        '?$invitedByQueryPrameter=' +
        UtilityService.removeSymbols(
            Services.globalDataNotifier?.localUser?.id);

    String shareMessage = ShareService.getPostShareMessage(
        postContent: postContent, completeUrl: completeUrl);

    switch (shareMethod) {
      case ShareMethod.Facebook:
        try {
          response = await flutterShareMe.shareToFacebook(
            url: completeUrl,
            msg: shareMessage,
          );
        } catch (e, s) {
          FirebaseCrashlytics.instance.recordError(
              "Error sharing post with Facebook : " + e.toString(), s);
          await shareWithOptions(
              postId: postId,
              completeUrl: completeUrl,
              postContent: postContent);
        }
        break;
      case ShareMethod.Whatsapp:
        try {
          response = await flutterShareMe.shareToWhatsApp(
            msg: shareMessage,
          );
        } catch (e, s) {
          FirebaseCrashlytics.instance.recordError(
              "Error sharing post with Whatsapp : " + e.toString(), s);
          await shareWithOptions(
              postId: postId,
              completeUrl: completeUrl,
              postContent: postContent);
        }
        break;
      default:
    }
    return response;
  }
}
