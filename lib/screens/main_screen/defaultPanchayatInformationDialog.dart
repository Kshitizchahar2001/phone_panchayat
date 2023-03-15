// ignore_for_file: file_names, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/images.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:online_panchayat_flutter/utils/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';

class DefaultPanchayatInformationDialogue extends StatelessWidget {
  final Function onContinue;
  const DefaultPanchayatInformationDialogue(
      {Key key, @required this.onContinue})
      : super(key: key);

  final int iconHeightUnit = 16;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: context.safePercentHeight * (iconHeightUnit / 2)),
              child: Container(
                padding: getPostWidgetSymmetricPadding(context),
                width: double.infinity,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: context.safePercentHeight * (iconHeightUnit / 2),
                      // color: Colors.pink,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.grey[400],
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: context.safePercentHeight * 3,
                    ),
                    Text(
                      "जानिए अपने क्षेत्र की दैनिक खबरें",
                      style: Theme.of(context).textTheme.headline2.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.m10),
                          ),
                    ),
                    SizedBox(
                      height: context.safePercentHeight * 5,
                    ),
                    Text(
                      "हमारी टीम अधिक समाचार संसाधन और बेहतर उपयोगकर्ता अनुभव प्रदान करने के लिए काम कर रही है, इसलिए, अभी के लिए आपको गंगापुर पंचायत से जोड़ा जा रहा है। जल्द ही आप अपने क्षेत्र को बदलने और अपने क्षेत्र से संबंधित समाचार प्राप्त करने में सक्षम होंगे। ",
                      style: Theme.of(context).textTheme.headline2.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.s10),
                          ),
                    ),
                    SizedBox(
                      height: context.safePercentHeight * 5,
                    ),
                    CustomButton(
                      text: "OK",
                      buttonColor: maroonColor,
                      autoSize: true,
                      onPressed: () {
                        Navigator.pop(context);
                        onContinue();
                      },
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Image(
                height: context.safePercentHeight * iconHeightUnit,
                image: AssetImage(app_icon),
              ),
            )
          ],
        ),
      ],
    );
  }
}
