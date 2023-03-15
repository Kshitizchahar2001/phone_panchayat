// ignore_for_file: file_names, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

import 'Data/placeSuggestionData.dart';

class SuggestionMessageScreen extends StatefulWidget {
  final PlaceSuggestionData placeSuggestionData;
  const SuggestionMessageScreen({
    Key key,
    @required this.placeSuggestionData,
  }) : super(key: key);

  @override
  State<SuggestionMessageScreen> createState() =>
      _SuggestionMessageScreenState();
}

class _SuggestionMessageScreenState extends State<SuggestionMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "सुझाव के लिए धन्यवाद",
            style: Theme.of(context).textTheme.headline1.copyWith(
                  fontSize: responsiveFontSize(
                    context,
                    size: ResponsiveFontSizes.s10,
                  ),
                ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          constraints: BoxConstraints.expand(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.safePercentWidth * 8,
              vertical: context.safePercentWidth * 8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.check,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    ResponsiveHeight(
                      heightRatio: 10,
                    ),
                    Text(
                      "आपको जल्द ही आपके क्षेत्र से जोड़ा जायेगा, तब तक अपने राज्य की खबरों का आनंद लें",
                      style: Theme.of(context).textTheme.headline2.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: responsiveFontSize(
                            context,
                            size: ResponsiveFontSizes.m,
                          )),
                    ),
                  ],
                ),
                CustomButton(
                  text: SUBMIT.tr(),
                  buttonColor: maroonColor,
                  autoSize: true,
                  onPressed: () {
                    widget.placeSuggestionData.place
                        .signupWithSuggestion(context);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
