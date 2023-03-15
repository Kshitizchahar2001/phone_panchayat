// ignore_for_file: deprecated_member_use, prefer_const_constructors

import "package:flutter/material.dart";
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/appliance_item.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:velocity_x/velocity_x.dart';

class RepairSection extends StatelessWidget {
  const RepairSection({
    Key key,
    @required this.serviceList,
    @required this.title,
    @required this.buttonText,
    this.noOfElements = 2,
    @required this.currentUserId,
  }) : super(key: key);

  final List<Map> serviceList;
  final String title;
  final String buttonText;
  final int noOfElements;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.safePercentWidth * 3,
            vertical: context.safePercentHeight * 1.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: Theme.of(context).textTheme.headline6),
            GridView.count(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              primary: false,
              padding:
                  EdgeInsets.symmetric(vertical: context.safePercentHeight * 3),
              crossAxisSpacing: context.safePercentWidth * 3,
              mainAxisSpacing: context.safePercentHeight * 1.5,
              crossAxisCount: 2,
              children: serviceList
                  .sublist(
                      0,
                      noOfElements < serviceList.length
                          ? noOfElements
                          : serviceList.length)
                  .map<Widget>((appliance) {
                return ApplianceItem(
                  service: appliance,
                  currentUserId: currentUserId,
                );
              }).toList(),
            ),
            // SizedBox(height: context.safePercentHeight * 2),

            TextButton(
              onPressed: () {
                // Firebase analytics
                AnalyticsService.firebaseAnalytics.logEvent(
                    name: "sp_see_more_services",
                    parameters: {
                      "user_id": currentUserId ?? "",
                      "title": title
                    });
                // Send to all services screen
                context.vxNav.push(Uri.parse(MyRoutes.seeAllServices),
                    params: serviceList);
              },
              child: Text(
                buttonText,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(maroonColor)),
            ),
          ],
        ),
      ),
    );
  }
}
