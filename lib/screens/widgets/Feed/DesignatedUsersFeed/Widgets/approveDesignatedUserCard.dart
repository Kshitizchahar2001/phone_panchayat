// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/DesignatedUsersFeed/DesignatedUserData/designatedUserData.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/DesignatedUsersFeed/Widgets/userDetail.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:online_panchayat_flutter/utils/custom_button.dart';
import 'package:online_panchayat_flutter/utils/showDialog.dart';
import 'designatedUserDetailsColumn.dart';

class ApproveDesignatedUserCard extends StatelessWidget {
  final DesignatedUserData designatedUserData;
  const ApproveDesignatedUserCard({Key key, @required this.designatedUserData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          color: Theme.of(context).cardColor,
          child: Padding(
              padding: getPostWidgetSymmetricPadding(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DesignatedUserDetailsColumn(
                    designatedUserData: designatedUserData,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  UserDetail(
                      heading: "स्टेटस",
                      value: designatedUserData.isUserVerified
                          ? "Verified"
                          : "Not verified"),
                  SizedBox(
                    height: 10,
                  ),
                  ApproveUserRequest(
                    designatedUserData: designatedUserData,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ))),
    );
  }
}

class ApproveUserRequest extends StatelessWidget {
  final DesignatedUserData designatedUserData;
  const ApproveUserRequest({
    Key key,
    @required this.designatedUserData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (designatedUserData.isUserVerified) {
      return Container();
    } else {
      return CustomButton(
        text: APPROVE_MEMBER,
        autoSize: true,
        buttonColor: Colors.green,
        onPressed: () async {
          showMaterialDialog(context);
          await designatedUserData.approveUser();
          Navigator.pop(context);
        },
      );
    }
  }
}
