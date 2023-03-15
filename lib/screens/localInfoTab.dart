// ignore_for_file: file_names, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/screens/main_screen/floatingActionButton.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';
import 'in_app_web_view_screen.dart';

class LocalInfoTab extends StatefulWidget {
  const LocalInfoTab({Key key}) : super(key: key);

  @override
  LocalInfoTabState createState() => LocalInfoTabState();
}

class LocalInfoTabState extends State<LocalInfoTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CustomListTile(
            onTap: () {
              context.vxNav.push(Uri.parse(MyRoutes.viewAllDesignatedUsers));
            },
            text: VIEW_ELECTED_MEMBERS,
          ),
          CustomListTile(
            onTap: () {
              context.vxNav.push(Uri.parse(MyRoutes.viewAllComplaintsScreen));
            },
            text: VIEW_MY_AREA_COMPLAINTS,
          ),
          // CustomListTile(
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(
          //       builder: (context) {
          //         return InAppWebViewExampleScreen(
          //           url:
          //               "https://rural.nic.in/departments/departments-of-mord/department-rural-development",
          //           appbarTitle: VIEW_GRAM_PANCHAYAT_DESCRIPTION,
          //         );
          //       },
          //     ));
          //   },
          //   text: VIEW_GRAM_PANCHAYAT_DESCRIPTION,
          // ),
          // CustomListTile(
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(
          //       builder: (context) {
          //         return InAppWebViewExampleScreen(
          //           url:
          //               "https://rural.nic.in/departments/departments-of-mord/department-rural-development",
          //           appbarTitle: GRAM_PANCHAYAT_WORK,
          //         );
          //       },
          //     ));
          //   },
          //   text: GRAM_PANCHAYAT_WORK,
          // ),
          CustomListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return InAppWebViewScreen(
                    url:
                        "https://mnregaweb2.nic.in/netnrega/dynamic_account_details_ippe.aspx",
                    appbarTitle: VIEW_NREGA_JOB_CARD_LIST,
                  );
                },
              ));
            },
            text: VIEW_NREGA_JOB_CARD_LIST,
          ),
          CustomListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return InAppWebViewScreen(
                    url:
                        "https://pmkisan.gov.in/Rpt_BeneficiaryStatus_pub.aspx",
                    appbarTitle: VIEW_FARMER_FECILITATION_LIST,
                  );
                },
              ));
            },
            text: VIEW_FARMER_FECILITATION_LIST,
          ),
          CustomListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return InAppWebViewScreen(
                    url: "https://pmkisan.gov.in/BeneficiaryStatus.aspx",
                    appbarTitle: VIEW_FARMER_STATUS,
                  );
                },
              ));
            },
            text: VIEW_FARMER_STATUS,
          ),
          CustomListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return InAppWebViewScreen(
                    url:
                        "https://pmaymis.gov.in/Open/Find_Beneficiary_Details.aspx",
                    appbarTitle: VIEW_PRIME_MINISTER_AWAS_YOJNA_STATUS,
                  );
                },
              ));
            },
            text: VIEW_PRIME_MINISTER_AWAS_YOJNA_STATUS,
          ),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () => performWriteOperationAfterConditionsCheck(
          registrationInstructionText:
              REGISTRATION_MESSAGE_BEFORE_COMPLAINT_CREATION,
          writeOperation: () {
            context.vxNav.push(Uri.parse(MyRoutes.selectComplaintArea));
          },
          context: context,
        ),
        child: FloatingActionButtonToAddComplaint(),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final Function onTap;
  final String text;
  const CustomListTile({
    Key key,
    @required this.onTap,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: getPostWidgetSymmetricPadding(
          context,
          horizontal: 0,
          vertical: 0.4,
        ),
        child: Card(
          color: Theme.of(context).cardColor,
          shadowColor: Theme.of(context).shadowColor,
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      text.tr(),
                      style: Theme.of(context).textTheme.headline2.copyWith(
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.m),
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ),
                SizedBox(
                  width: context.safePercentWidth * 2.5,
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).iconTheme.color.withOpacity(0.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
