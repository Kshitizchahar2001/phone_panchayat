// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';

import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:online_panchayat_flutter/utils/custom_button.dart';
import 'package:online_panchayat_flutter/utils/heading_and_subheading.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterPromptPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Padding(
              padding: getPostWidgetSymmetricPadding(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: context.safePercentHeight * 10,
                  ),
                  HeadingAndSubheading(
                    heading: register_prompt,
                    subheading: Please_Register,
                  ),
                  SizedBox(
                    height: context.safePercentHeight * 40,
                  ),
                  CustomButton(
                    text: Register_Heading,
                    buttonColor: maroonColor,
                    autoSize: true,
                    onPressed: () {
                      context.vxNav.push(Uri.parse(MyRoutes.registrationRoute));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
