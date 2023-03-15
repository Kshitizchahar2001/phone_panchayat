// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/enum/buttonType.dart';
import 'package:online_panchayat_flutter/models/Status.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/animateButtons.dart';
import 'package:provider/provider.dart';
import 'InteractiveBar.dart';

class LikeButton extends StatefulWidget {
  final bool isDarkTheme;
  final PostData postData;
  final int index;
  final AnimateButtons animateButtons;

  LikeButton({
    @required this.isDarkTheme,
    @required this.postData,
    @required this.index,
    @required this.animateButtons,
  });

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  InteractiveButtonModel interactiveButtonModel;
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      value: 1.0,
      upperBound: 1.0,
      lowerBound: 0.0,
      duration: Duration(milliseconds: 200),
    );

    _animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
        reverseCurve: Curves.easeInBack);

    interactiveButtonModel = InteractiveButtonModel(
      icon: getLikeButtonImageFromStatus(Status.INACTIVE),
      onPressed: onLikeButtonTap,
      buttonType: ButtonType.Like,
      onLongPress: () {
        // context.vxNav.push(Uri.parse(MyRoutes.viewReactionsRoute),
        //     params: widget.postData.post.id);
      },
    );

    super.initState();
  }

  Future<void> animateLikeButton() async {
    await _controller.animateBack(0.5);
    _controller.animateTo(1.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onLikeButtonTap() => widget.postData.onLikeButtonPressed();

  @override
  Widget build(BuildContext context) {
    return Consumer<PostData>(
      builder: (context, value, child) {
        interactiveButtonModel.icon =
            getLikeButtonImageFromStatus(value.myLikeStatus);
        animateLikeButton();
        return ScaleTransition(
          scale: _animation,
          alignment: Alignment.center,
          child: InteractiveBarButton(
              eachInteractiveButtonModel: interactiveButtonModel),
        );
      },
    );
  }

  Widget getLikeButtonImageFromStatus(Status status) {
    Color iconColor;
    if (status == Status.ACTIVE) {
      iconColor = Colors.red;
    } else {
      iconColor = (widget.isDarkTheme) ? Colors.white : Colors.grey[800];
    }
    return Row(
      children: [
        Icon(
          FontAwesomeIcons.heart,
          color: iconColor,
          size: likeIconSize,
        ),
        SizedBox(
          width: 2,
        ),
        Consumer<PostData>(
          builder: (context, value, child) {
            return getIconCount(context, value.numberOfLikes);
          },
        ),
      ],
    );
  }
}
