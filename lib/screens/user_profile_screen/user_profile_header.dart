// ignore_for_file: unnecessary_string_interpolations, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/screens/user_profile_screen/user_profile_data.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({
    Key key,
    @required this.user,
    @required this.globalDataNotifier,
    @required this.userProfileData,
  }) : super(key: key);

  final User user;
  final GlobalDataNotifier globalDataNotifier;
  final UserProfileData userProfileData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPostWidgetSymmetricPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: context.safePercentHeight * 6,
                backgroundColor: Colors.white,
                foregroundImage:
                    (user.image != null) ? NetworkImage(user.image) : null,
              ),
              SizedBox(
                width: context.safePercentWidth * 3,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user.name}",
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.m),
                        ),
                  ),
                  Text(
                    "${user.designation}",
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s),
                        ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: context.safePercentHeight * 3),
          ValueListenableBuilder<bool>(
            valueListenable:
                userProfileData.isUserRelationChangeMutationRunning,
            builder: (context, value, child) {
              return CustomButton(
                text: userProfileData.getButtonText(),
                autoSize: true,
                buttonColor: maroonColor,
                edgeInsets: getPostWidgetSymmetricPadding(context,
                    horizontal: 10, vertical: 1.2),
                onPressed: () async {
                  showMaterialDialog(context);
                  await userProfileData.onButtonPressed();
                  Navigator.pop(context);

                  String snackBarText =
                      (userProfileData.isProfileOwnerFollowedByProfileVisitor)
                          ? "User Followed"
                          : "User Unfollowed";

                  final snackBar = SnackBar(
                    content: Text(snackBarText),
                    duration: Duration(
                      milliseconds: 2500,
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
