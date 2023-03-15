// ignore_for_file: prefer_const_constructors, void_checks, avoid_print, file_names, unnecessary_string_interpolations, prefer_adjacent_string_concatenation

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';

class DynamicLinkService {
  static Future<Uri> generatePostSpecificShortDynamicLink({
    @required String postId,
    @required String postThumbnail,
    @required String postDescription,
  }) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: DYNAMIC_LINKS_URL_PREFIX,
      link: Uri.parse('$APP_HOST_URL' + '/PostView' + '?id=' + postId),
      // link: Uri.parse('$APP_HOST_URL' + '/PostView' + '?id=' + postId),
      // ignore: todo
      //TODO: test update version
      androidParameters: AndroidParameters(
        packageName: 'com.panchayat.online',
        minimumVersion: 102,
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.panchayat.online',
        minimumVersion: '1.0.2',
        appStoreId: '123456789',
      ),
      googleAnalyticsParameters: GoogleAnalyticsParameters(
        campaign: 'post-share',
        content: postId,
        medium: 'social',
        source: 'mobile-app',
      ),
      // itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
      //   providerToken: '123456',
      //   campaignToken: 'example-promo',
      // ),
      socialMetaTagParameters: SocialMetaTagParameters(
          title: 'फ़ोन पंचायत',
          description: postDescription ??
              'your tool for local area updates and networking.',
          imageUrl: Uri.parse(
            (postThumbnail != null && postThumbnail != "")
                ? postThumbnail
                : APP_ICON_URL,
          )),
    );

    // final Uri dynamicUrl = await parameters.buildUrl();
    final ShortDynamicLink shortDynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    final Uri shortUrl = shortDynamicLink.shortUrl;
    return shortUrl;
  }

  static Future<Uri> generateReferralLink({
    /// input user id without + sign
    @required String userId,
  }) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: DYNAMIC_LINKS_REFERRAL_URL_PREFIX,
      link: Uri.parse(
          '$APP_HOST_URL' + '/' + '?$invitedByQueryPrameter=' + userId),
      androidParameters: AndroidParameters(
        packageName: 'com.panchayat.online',
        minimumVersion: 102,
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.panchayat.online',
        minimumVersion: '1.0.2',
        appStoreId: '123456789',
      ),
      googleAnalyticsParameters: GoogleAnalyticsParameters(
        campaign: 'post-share',
        content: userId,
        medium: 'social',
        source: 'mobile-app',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
          title: 'फ़ोन पंचायत',
          description:
              'अपने क्षेत्र की अपनी ऐप्प | अपने आस पास की  गतिविधियॉ, घटनाए एवं अपडेट तुरंत हम तक पंहुचा देती है | अपने क्षेत्र के मुद्दों को उठाने के लिए आप भी मेरी तरह फ़ोन पंचायत के सदस्य बनिये और डाउनलोड कीजिये फ़ोन पंचायत ऍप |',
          imageUrl: Uri.parse(
            APP_ICON_URL,
          )),
    );

    final ShortDynamicLink shortDynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    final Uri shortUrl = shortDynamicLink.shortUrl;
    return shortUrl;
  }

  static Future<Uri> initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink.listen(
        (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        print(deepLink.toString());
        return deepLink;
        // Navigator.pushNamed(context, deepLink.path);
      }
    }, onError: (e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      print(deepLink.toString());
      print("url recieved in dynamicLinkService");
      return deepLink;
      // Navigator.pushNamed(context, deepLink.path);
    }
    return null;
  }
}
