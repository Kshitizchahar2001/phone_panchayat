// ignore_for_file: file_names, unnecessary_string_interpolations, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => context.vxNav
              .push(Uri.parse(MyRoutes.profileRoute), params: user),
          child: Padding(
            padding: getPostWidgetSymmetricPadding(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: context.safePercentHeight * 3.2,
                  backgroundColor: Colors.white,
                  foregroundImage:
                      user.image != null ? NetworkImage(user.image) : null,
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
                      "${user.name.toString()}",
                      style: Theme.of(context).textTheme.headline1.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.s),
                          ),
                    ),
                    Text("${user.designation.toString()}",
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.xs10),
                            ))
                  ],
                )
              ],
            ),
          ),
        ),
        Divider(
          color: KThemeLightGrey,
          height: 1,
          indent: context.safePercentWidth * 4,
          endIndent: context.safePercentWidth * 4,
        ),
      ],
    );
  }
}
