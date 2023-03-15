// ignore_for_file: file_names, prefer_const_constructors, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:easy_localization/easy_localization.dart';

class ElectedMemberVerificationPendingScreen extends StatelessWidget {
  const ElectedMemberVerificationPendingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.pending,
                size: 35,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                MEMBER_VERIFICATION_PENDING.tr(),
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
