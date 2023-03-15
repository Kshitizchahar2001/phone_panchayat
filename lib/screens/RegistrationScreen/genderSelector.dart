// ignore_for_file: file_names, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/Gender.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/registrationScreenData.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class GenderSelector extends StatefulWidget {
  final ProfileData profileData;
  const GenderSelector({Key key, @required this.profileData}) : super(key: key);

  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.profileData.gender,
      builder: (context, value, child) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            GenderTab(
              iconData: FontAwesomeIcons.male,
              text: MALE.tr(),
              profileData: widget.profileData,
              gender: Gender.MALE,
              // gender: Gender.MALE,
            ),
            GenderTab(
              iconData: FontAwesomeIcons.female,
              text: FEMALE.tr(),
              profileData: widget.profileData,
              gender: Gender.FEMALE,
            ),
            GenderTab(
              iconData: FontAwesomeIcons.transgender,
              text: OTHER.tr(),
              profileData: widget.profileData,
              gender: Gender.OTHER,
            ),
          ],
        );
      },
    );
  }
}

class GenderTab extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Gender gender;
  final ProfileData profileData;
  const GenderTab(
      {Key key, this.iconData, this.text, this.gender, this.profileData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (profileData.gender.value != gender) {
            profileData.gender.value = gender;
          }
        },
        child: Column(
          children: [
            FaIcon(
              iconData,
              color: profileData.gender.value == gender
                  ? maroonColor.withOpacity(0.8)
                  : maroonColor.withOpacity(0.2),
            ),
            SizedBox(height: 3),
            Text(
              text,
              style: Theme.of(context).textTheme.headline3.copyWith(
                    fontSize: responsiveFontSize(context,
                        size: ResponsiveFontSizes.xs),
                    color: profileData.gender.value == gender
                        ? maroonColor
                        : Theme.of(context).textTheme.headline3.color,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
