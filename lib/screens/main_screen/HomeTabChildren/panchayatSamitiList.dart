// ignore_for_file: unused_import, file_names, prefer_const_constructors, prefer_is_empty, deprecated_member_use, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/utils/StringCaseChange.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:velocity_x/velocity_x.dart';
import 'panchayatSamitiListData.dart';

class PanchayatSamitiList extends StatefulWidget {
  final TabController tabController;
  const PanchayatSamitiList({Key key, @required this.tabController})
      : super(key: key);

  @override
  State<PanchayatSamitiList> createState() => _PanchayatSamitiListState();
}

class _PanchayatSamitiListState extends State<PanchayatSamitiList> {
  PanchayatSamitiListData panchayatSamitiListData;
  static const double horizontalPadding = 12.0;
  @override
  void initState() {
    panchayatSamitiListData = PanchayatSamitiListData();
    super.initState();
  }

  @override
  void dispose() {
    panchayatSamitiListData.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PanchayatSamitiListData>.value(
      value: panchayatSamitiListData,
      builder: (context, child) {
        return Consumer<PanchayatSamitiListData>(
          builder: (context, value, child) {
            if (value.loading == true) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(maroonColor),
                ),
              );
            } else {
              if (panchayatSamitiListData.list.length > 0)
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        horizontalPadding,
                        10.0,
                        horizontalPadding,
                        12.0,
                      ),
                      child: Text(
                        'पंचायत समिति चुनें',
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.s10),
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: panchayatSamitiListData.list.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          Places val = panchayatSamitiListData.list[index];
                          if (val.name_hi != null || val.name_en != null)
                            return InkWell(
                              onTap: () {
                                context.vxNav.push(
                                  Uri.parse(MyRoutes
                                      .designatedMembersByPanchayatSamitiScreen),
                                  params: val.id,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: horizontalPadding,
                                ),
                                child: Text(
                                  StringCaseChange.onlyFirstLetterCapital(
                                          val.name_hi ?? val.name_en)
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      .copyWith(
                                          fontSize: responsiveFontSize(context,
                                              size: ResponsiveFontSizes.s10),
                                          fontWeight: FontWeight.normal),
                                ),
                              ),
                            );
                          else
                            return Container();
                        },
                      ),
                    ),
                  ],
                );
              else
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'अभी सरपंच की सूची उपलब्ध नहीं है, आप जल्द ही अपने जिले के सरपंच देख पाएंगे',
                          style: Theme.of(context).textTheme.headline3.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: responsiveFontSize(context,
                                    size: ResponsiveFontSizes.s),
                              ),
                          textAlign: TextAlign.center,
                        ).tr(),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      CustomButton(
                        text: 'अपने क्षेत्र की खबरें देखें',
                        boxShadow: [],
                        onPressed: () {
                          widget.tabController.animateTo(0);
                        },
                      ),
                    ],
                  ),
                );
            }
          },
        );
      },
    );
  }
}
