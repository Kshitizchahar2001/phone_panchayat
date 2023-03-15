// ignore_for_file: file_names, prefer_const_constructors, curly_braces_in_flow_control_structures, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/designatedUserStatus.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:provider/provider.dart';
import 'electedMemberRegistrationScreenData.dart';
import 'widgets/electedMemberVerificationPendingScreen.dart';
import 'widgets/registrationForm/electedMemberRgistrationForm.dart';

class ElectedMemberScreen extends StatefulWidget {
  const ElectedMemberScreen({Key key}) : super(key: key);

  @override
  _ElectedMemberScreenState createState() => _ElectedMemberScreenState();
}

class _ElectedMemberScreenState extends State<ElectedMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<ElectedMemberRegistrationScreenData>(
        create: (context) => ElectedMemberRegistrationScreenData(),
        builder: (context, child) {
          return Consumer<ElectedMemberRegistrationScreenData>(
            builder: (context, value, child) {
              if (value.loading)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else if (!value.designatedUserQueryData.success) {
                return Center(
                  child: Text(
                    "error!",
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.m)),
                  ),
                );
              } else if (!value.designatedUserQueryData.userFound) {
                return ElectedMemberRegistrationForm();
              } else {
                if (value.designatedUserQueryData.designatedUser.status ==
                        DesignatedUserStatus.UNVERIFIED ||
                    value.designatedUserQueryData.designatedUser.status == null)
                  return ElectedMemberVerificationPendingScreen();
                else {
                  return Center(
                    child: Text(
                      "Verified",
                      style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.m)),
                    ),
                  );
                }
              }
            },
          );
        },
      ),
    );
  }
}
