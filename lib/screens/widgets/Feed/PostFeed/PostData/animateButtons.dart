// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/buttonType.dart';

class AnimateButtons extends ChangeNotifier {
  AnimateButtons() {
    _animateLikeButton = true;
    _animateCommentButton = false;
    _animateShareButton = false;
  }

  bool _animateLikeButton;
  bool _animateCommentButton;
  bool _animateShareButton;

  void onLikeButtonPressed({bool logLikeEvent = true}) {
    if (!_animateLikeButton) return;
    _animateLikeButton = false;
    _animateCommentButton = true;
    notifyListeners();
  }

  void onCommentButtonPressed() {
    if (!_animateCommentButton) return;
    _animateCommentButton = false;
    _animateShareButton = true;
    notifyListeners();
  }

  void onShareButtonPressed() {
    if (!_animateShareButton) return;
    _animateShareButton = false;
    notifyListeners();
  }

  bool animateThisButton(ButtonType buttonType) {
    switch (buttonType) {
      case ButtonType.Like:
        return _animateLikeButton;
        break;
      case ButtonType.Comment:
        return _animateCommentButton;
        break;
      case ButtonType.Share:
        return _animateShareButton;
        break;
      default:
        return false;
    }
  }

  //

  //

  bool get animateShareButton => _animateShareButton;

  bool get animateCommentButton => _animateCommentButton;

  bool get animateLikeButton => _animateLikeButton;
}
