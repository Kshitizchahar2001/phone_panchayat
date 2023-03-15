// ignore_for_file: implementation_imports, prefer_const_constructors, curly_braces_in_flow_control_structures, deprecated_member_use

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/IndividualProfessionalScreen/setRadiusDialog.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/professional_card.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/professional_list_data.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/shimmerEffects/rectangular_image.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';
import 'package:auto_animated/auto_animated.dart';

class ProfessionalList extends StatefulWidget {
  const ProfessionalList({Key key}) : super(key: key);

  @override
  State<ProfessionalList> createState() => _ProfessionalListState();
}

class _ProfessionalListState extends State<ProfessionalList> {
  ProfessionalListData _professionalListData;

  final listViewAnimationOptions = LiveOptions(
    showItemInterval: Duration(milliseconds: 50),
    showItemDuration: Duration(milliseconds: 100),
    visibleFraction: 0.001,
    reAnimateOnVisibility: false,
  );

  @override
  void initState() {
    _professionalListData =
        Provider.of<ProfessionalListData>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(color: maroonColor),
        title: Text(
          _professionalListData.service["name"],
          style: TextStyle(fontSize: 15.0, color: maroonColor),
        ).tr(),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Material(
                      type: MaterialType.transparency,
                      child: SetRadiusDialog(
                        radiusData: _professionalListData,
                      ),
                    );
                  });
            },
            tooltip: "Filter",
            icon: Icon(FontAwesomeIcons.filter),
          ),
        ],
      ),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Consumer<ProfessionalListData>(
            builder: (context, value, child) {
              if (value.loading)
                return ListLoadingShimmer();
              else if (value.locationPermissonDenied)
                return SizedBox(
                  height: context.safePercentHeight * 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LOCATION_PERMISSON_DENIED,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.m)),
                      ).tr(),
                      ElevatedButton(
                        onPressed: () => value.askForCurrentLocation(),
                        child: Text(
                          SELECT_LOCATION,
                          style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.s),
                              color: Colors.white),
                        ).tr(),
                        style: ElevatedButton.styleFrom(primary: maroonColor),
                      ),
                    ],
                  ),
                );
              else if (value.professionals.isEmpty)
                return SizedBox(
                  height: context.safePercentHeight * 60,
                  child: Center(
                    child: Text(
                      NO_PROFESSIONALS_MESSAGE.tr(
                          namedArgs: {"km": "${_professionalListData.radius}"}),
                      style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: responsiveFontSize(
                              context,
                              size: ResponsiveFontSizes.s,
                            ),
                          ),
                    ),
                  ),
                );

              /// Animated list which comes from package auto_animated
              ///
              return LiveList.options(
                options: listViewAnimationOptions,
                shrinkWrap: true, // 1st add
                physics: ClampingScrollPhysics(),
                itemCount: _professionalListData.professionals.length,
                padding: EdgeInsets.only(top: 10),
                itemBuilder: (context, index, animation) {
                  return FadeTransition(
                    opacity: Tween<double>(
                      begin: 0,
                      end: 1,
                    ).animate(animation),
                    // And slide transition
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0, -0.1),
                        end: Offset.zero,
                      ).animate(animation),
                      // Paste you Widget
                      child: ProfessionalCard(
                        professional:
                            _professionalListData.professionals[index],
                        myLocation: _professionalListData.myLocation,
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
