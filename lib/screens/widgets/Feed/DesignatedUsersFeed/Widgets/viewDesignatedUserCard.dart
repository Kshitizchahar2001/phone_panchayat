// ignore_for_file: file_names, prefer_const_constructors, unnecessary_string_interpolations, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/screens/electedMemberRegistrationScreen/widgets/registrationForm/Data/ElectedMemberRegistrationFormData.dart';
import 'package:online_panchayat_flutter/screens/find_professionals_screen.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/DesignatedUsersFeed/DesignatedUserData/designatedUserData.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/StringCaseChange.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewDesignatedUserCard extends StatelessWidget {
  final DesignatedUserData designatedUserData;
  const ViewDesignatedUserCard({Key key, @required this.designatedUserData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: Theme.of(context).cardColor,
        shadowColor: Theme.of(context).shadowColor,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: Image.network(
                    designatedUserData.designatedUser.user.image ??
                        APP_ICON_URL,
                  ).image,
                ),
              ),
              Flexible(
                child: Container(),
              ),
              Flexible(
                flex: 14,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${capitalise(designatedUserData.designatedUser.user?.name)}',
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              fontSize: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.m),
                            ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: maroonColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child: Text(
                            electedMembersDesignation[designatedUserData
                                    .designatedUser?.designation]
                                .toString(),
                            style:
                                Theme.of(context).textTheme.subtitle2.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: responsiveFontSize(
                                        context,
                                        size: ResponsiveFontSizes.xs10,
                                      ),
                                      color: Colors.white,
                                    )),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: StringCaseChange.onlyFirstLetterCapital(
                                  designatedUserData.designatedUser.identifier_2
                                      .toString()),
                            ),
                            TextSpan(text: ","),
                            TextSpan(
                              text: StringCaseChange.onlyFirstLetterCapital(
                                designatedUserData.designatedUser.identifier_1
                                    .toString(),
                              ),
                            ),
                          ],
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: responsiveFontSize(context,
                                    size: ResponsiveFontSizes.s),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Container(),
              ),
              IconButton(
                onPressed: () {
                  AnalyticsService.firebaseAnalytics
                      .logEvent(name: "call_designated_user", parameters: {
                    "designated_user_phone_number":
                        designatedUserData.designatedUser.id.toString(),
                    "designation": designatedUserData.designatedUser.designation
                        .toString(),
                    "designated_user_name":
                        designatedUserData.designatedUser.user?.name.toString(),
                    "caller_id":
                        Services.globalDataNotifier.localUser.id.toString(),
                  });
                  launch('tel:${designatedUserData.designatedUser.id}');
                },
                icon: Icon(
                  FontAwesomeIcons.phoneAlt,
                  size: responsiveFontSize(context,
                      size: ResponsiveFontSizes.m10),
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
