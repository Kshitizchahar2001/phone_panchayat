// ignore_for_file: file_names, prefer_const_constructors, duplicate_ignore, unnecessary_string_interpolations, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/DesignatedUserType.dart';
import 'package:online_panchayat_flutter/screens/electedMemberRegistrationScreen/widgets/registrationForm/Data/ElectedMemberRegistrationFormData.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/DesignatedUsersFeed/DesignatedUserData/designatedUserData.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'userDetail.dart';

class DesignatedUserDetailsColumn extends StatelessWidget {
  final DesignatedUserData designatedUserData;
  const DesignatedUserDetailsColumn(
      {Key key, @required this.designatedUserData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: maroonColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.2),
                  // color: maroonColor.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 5,
                  // ignore: prefer_const_constructors
                  offset: Offset(0, 2),
                )
              ]),
          child: CircleAvatar(
            radius: 35,
            // radius: context.safePercentHeight * 3.2,
            backgroundColor: Colors.white,
            foregroundImage:
                (designatedUserData.designatedUser.user?.image?.toString() !=
                        null)
                    ? NetworkImage(designatedUserData.designatedUser.user.image)
                    : null,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${designatedUserData.designatedUser.user?.name}",
              style: Theme.of(context).textTheme.headline1.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: responsiveFontSize(context,
                        size: ResponsiveFontSizes.s),
                  ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
                electedMembersDesignation[
                    designatedUserData.designatedUser.designation],
                // "${designatedUserData.designatedUser.user?.designation}",
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontWeight: FontWeight.normal,
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.s),
                    )),
            SizedBox(
              width: 5,
            ),
          ],
        ),
        SizedBox(
          height: 25,
        ),
        UserDetail(
          heading:
              designatedUserData.designatedUser.type == DesignatedUserType.URBAN
                  ? MUNICIPALITY.tr()
                  : PANCHAYAT_COMMITTEE.tr(),
          value: designatedUserData.designatedUser.identifier_1.toString(),
        ),
        SizedBox(
          height: 5,
        ),
        UserDetail(
          heading:
              designatedUserData.designatedUser.type == DesignatedUserType.URBAN
                  ? "वार्ड"
                  : VILLAGE_PANCHAYAT.tr(),
          value: designatedUserData.designatedUser.identifier_2.toString(),
        ),
      ],
    );
  }
}
