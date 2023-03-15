// ignore_for_file: prefer_final_fields, duplicate_ignore, prefer_const_constructors, must_call_super, deprecated_member_use, curly_braces_in_flow_control_structures, unnecessary_string_interpolations, avoid_function_literals_in_foreach_calls

// ignore_for_file: prefer_final_fields

import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/firestoreModels/Profession.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

class FindProfessional extends StatefulWidget {
  const FindProfessional({Key key}) : super(key: key);

  @override
  _FindProfessionalState createState() => _FindProfessionalState();
}

class _FindProfessionalState extends State<FindProfessional>
    with AutomaticKeepAliveClientMixin<FindProfessional> {
  @override
  bool get wantKeepAlive => true;
  var _firestore = FirebaseFirestore.instance;
  ThemeMode themeMode;
  String theme;
  GlobalDataNotifier globalDataNotifier;
  @override
  void initState() {
    globalDataNotifier =
        Provider.of<GlobalDataNotifier>(context, listen: false);

    themeMode = Provider.of<ThemeProvider>(context, listen: false).getThemeMode;
    theme = themeMode.toString().split(".").last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: getPostWidgetSymmetricPadding(context, vertical: 0),
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            FIND_PROFESSIONALS,
            style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.l),
                fontWeight: FontWeight.w500),
          ).tr(),
          ResponsiveHeight(
            heightRatio: 1,
          ),
          Text(
            FIND_PROFESSIONALS_NEAR_YOU,
            style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.s10),
                fontWeight: FontWeight.normal),
          ).tr(),
          ResponsiveHeight(
            heightRatio: 1,
          ),
          FutureBuilder(
            future: getAvailableProfessionals(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              return ListView.builder(
                shrinkWrap: true, // 1st add
                physics: ClampingScrollPhysics(),
                itemCount: globalDataNotifier.availableProfessionals.length,
                padding: EdgeInsets.only(top: 10),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.vxNav.push(Uri.parse(MyRoutes.listProfessionals),
                          params:
                              globalDataNotifier.availableProfessionals[index]);
                    },
                    child: Padding(
                      padding: getPostWidgetSymmetricPadding(
                        context,
                        horizontal: 0,
                        vertical: 0.4,
                      ),
                      child: Card(
                        color: Theme.of(context).cardColor,
                        shadowColor: Theme.of(context).shadowColor,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '${capitalise((UtilityService.getCurrentLocale(context) == 'hi') ? globalDataNotifier.availableProfessionals[index].hi : globalDataNotifier.availableProfessionals[index].en)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      .copyWith(
                                        fontSize: responsiveFontSize(context,
                                            size: ResponsiveFontSizes.m),
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: context.safePercentWidth * 2.5,
                              ),
                              Icon(
                                Icons.arrow_forward,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () => performWriteOperationAfterConditionsCheck(
          registrationInstructionText:
              REGISTRATION_MESSAGE_BEFORE_REGISTERING_AS_PROFESSIONAL,
          writeOperation: () {
            context.vxNav.push(Uri.parse(MyRoutes.registerProfessional));
          },
          context: context,
        ),
        child: Container(
          width: 230,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: maroonColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                Flexible(
                  child: AutoSizeText(
                    REGISTER_YOURSELF_AS_PROFESSIONAL.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      // fontSize: 10,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getAvailableProfessionals() async {
    if (globalDataNotifier.availableProfessionals != null) {
      return;
    } else {
      globalDataNotifier.availableProfessionals = <Profession>[];
      await _firestore.collection('professionals').get().then((professions) {
        professions.docs.forEach((profession) {
          Map professionJson = profession.data();
          professionJson['id'] = profession.id;
          globalDataNotifier.availableProfessionals
              .add(Profession.fromJson(professionJson));
        });
      });
    }
  }
}

String capitalise(String s) {
  try {
    s = s.trim();
    var words = s.split(" ");
    String r = '';

    for (var word in words) {
      r += '${word[0].toUpperCase()}${word.substring(1)} ';
    }

    return r.trim();
  } catch (e) {
    return s;
  }
}
