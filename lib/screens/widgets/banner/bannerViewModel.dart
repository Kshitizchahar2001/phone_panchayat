// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:online_panchayat_flutter/services/services.dart';

import 'Data/banner_post_data.dart';

class BannerViewModel {
  BannerPostData _postData;
  bool hasData = false;
  bool showBanner = false;

  BannerPostData get postData => _postData;

  BannerViewModel(BannerPostData postData) {
    _postData = postData;
    initialiseBanner();
  }

  void initialiseBanner() {
    if (_postData.getFirstImage() != null &&
        !_postData.post.content.contains('hide')) showBanner = true;
    if (_postData.isPostOwnedByLoggedInUserOrAdministrator()) {
      Services.bannerPostData = _postData;
    }
  }

  void onClick(BuildContext context) {
    _postData.postMedia.mediaClicked(context);
  }
}
