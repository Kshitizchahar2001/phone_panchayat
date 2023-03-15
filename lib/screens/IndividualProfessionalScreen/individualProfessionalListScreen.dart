// ignore_for_file: file_names, use_key_in_widget_constructors, deprecated_member_use, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/IndividualProfessionalScreen/professionalTile.dart';
import 'package:online_panchayat_flutter/screens/IndividualProfessionalScreen/individualProfessionalListScreenData.dart';
import 'package:online_panchayat_flutter/screens/find_professionals_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import 'setRadiusDialog.dart';

class IndividualProfessionalListScreen extends StatefulWidget {
  @override
  _IndividualProfessionalListScreenState createState() =>
      _IndividualProfessionalListScreenState();
}

class _IndividualProfessionalListScreenState
    extends State<IndividualProfessionalListScreen> {
  IndividualProfessionalListScreenData individualProfessionalListScreenData;
  @override
  void initState() {
    individualProfessionalListScreenData =
        Provider.of<IndividualProfessionalListScreenData>(context,
            listen: false);
    // var user =
    //     Provider.of<GlobalDataNotifier>(context, listen: false).localUser;

    // = user.homeAdressLocation;

    // userId = user.id;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          capitalise((UtilityService.getCurrentLocale(context) == 'hi')
              ? individualProfessionalListScreenData.profession.hi
              : individualProfessionalListScreenData.profession.en),
          style: Theme.of(context).textTheme.headline2.copyWith(
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.m10),
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: ListView(
            padding: EdgeInsets.only(
              top: 15,
              left: context.safePercentWidth * 2,
              right: context.safePercentWidth * 2,
            ),
            children: <Widget>[
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Material(
                          type: MaterialType.transparency,
                          child: SetRadiusDialog(
                            radiusData: individualProfessionalListScreenData,
                          ),
                        );
                      });
                },
                child: Padding(
                  padding: getPostWidgetSymmetricPadding(context),
                  child: Consumer<IndividualProfessionalListScreenData>(
                      builder: (context, value, child) {
                    return RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: RADIUS_MESSAGE.tr(namedArgs: {
                              'km':
                                  '${individualProfessionalListScreenData.radius}'
                            }),
                          ),
                          TextSpan(
                            text: CHANGE_RADIUS.tr(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: maroonColor,
                            ),
                          ),
                        ],
                        style: Theme.of(context).textTheme.headline1.copyWith(
                                fontSize: responsiveFontSize(
                              context,
                              size: ResponsiveFontSizes.s,
                            )),
                      ),
                    );
                  }),
                ),
              ),
              Consumer<IndividualProfessionalListScreenData>(
                builder: (context, value, child) {
                  if (value.loading)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  else if (value.professionals.isEmpty)
                    return SizedBox(
                      height: context.safePercentHeight * 60,
                      child: Center(
                        child: Text(
                          NO_PROFESSIONALS_MESSAGE.tr(namedArgs: {
                            "km":
                                "${individualProfessionalListScreenData.radius}"
                          }),
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                fontSize: responsiveFontSize(
                                  context,
                                  size: ResponsiveFontSizes.s,
                                ),
                              ),
                        ),
                      ),
                    );
                  return ListView.builder(
                    shrinkWrap: true, // 1st add
                    physics: ClampingScrollPhysics(),
                    itemCount: individualProfessionalListScreenData
                        .professionals.length,
                    padding: EdgeInsets.only(top: 10),
                    itemBuilder: (context, index) {
                      return ProfessionalTile(
                        professional: individualProfessionalListScreenData
                            .professionals[index],
                        myLocation:
                            individualProfessionalListScreenData.myLocation,
                      );
                    },
                  );
                },
              )
            ]),
      ),
    );
  }
}
