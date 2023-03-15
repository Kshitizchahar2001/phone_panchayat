// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/screens/referAndEarnScreen/referredUserData.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:velocity_x/velocity_x.dart';

import 'referAndEarnData.dart';

class MyReferralsTab extends StatelessWidget {
  final ReferAndEarnData referAndEarnData;
  MyReferralsTab({
    Key key,
    @required this.referAndEarnData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: getPostWidgetSymmetricPadding(context),
      itemCount: referAndEarnData.listOfReferredUsers.length,
      itemBuilder: (_, index) {
        ReferredUserData referredUserData =
            referAndEarnData.listOfReferredUsers[index];
        return Card(
          color: Theme.of(context).cardColor,
          shadowColor: Theme.of(context).shadowColor,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      Image.network(referredUserData.imageUrl).image,
                  backgroundColor: Theme.of(context).cardColor,
                ),
                SizedBox(
                  width: context.safePercentWidth * 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      referredUserData.number ?? "",
                      style: Theme.of(context).textTheme.headline2.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.m10),
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      referredUserData.name ?? "",
                      style: TextStyle(
                        color: lightGreySubheading,
                        fontWeight: FontWeight.normal,
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.xs),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
