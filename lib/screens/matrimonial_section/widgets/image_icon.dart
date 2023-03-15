import "package:flutter/material.dart";
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:velocity_x/velocity_x.dart';

class ImageSelectIcon extends StatelessWidget {
  const ImageSelectIcon({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.onPress,
  }) : super(key: key);

  final Icon icon;
  final Widget text;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        constraints: BoxConstraints(minWidth: context.safePercentWidth * 20),
        padding: EdgeInsets.symmetric(
            vertical: context.safePercentHeight * 0.8,
            horizontal: context.safePercentWidth * 2.3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: lightGreySubheading.withOpacity(0.5)),
        child: Column(children: [
          icon,
          SizedBox(
            height: context.safePercentHeight * 1,
          ),
          text
        ]),
      ),
    );
  }
}
