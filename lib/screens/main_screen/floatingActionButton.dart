// ignore_for_file: file_names, prefer_const_constructors, deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:easy_localization/easy_localization.dart';

class FloatingActionButtonToCreatePost extends StatelessWidget {
  const FloatingActionButtonToCreatePost({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: maroonColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Icon(
          FontAwesomeIcons.pencilAlt,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}

class FloatingActionButtonToAddComplaint extends StatelessWidget {
  const FloatingActionButtonToAddComplaint({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
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
                ADD_COMPLAINT.tr(),
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
    );
  }
}

class FloatingActionButtonToRegisterAsProfessional extends StatelessWidget {
  const FloatingActionButtonToRegisterAsProfessional({Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
