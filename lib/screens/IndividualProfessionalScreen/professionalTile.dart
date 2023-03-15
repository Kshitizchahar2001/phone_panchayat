// ignore_for_file: file_names, must_be_immutable, prefer_const_constructors, unnecessary_string_interpolations, deprecated_member_use, avoid_print, constant_identifier_names

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/firestoreModels/Professional.dart';
import 'package:online_panchayat_flutter/screens/IndividualProfessionalScreen/individualProfessionalListScreenData.dart';
import 'package:online_panchayat_flutter/screens/RegisterProfessionalScreen/register_professional_screen.dart';
import 'package:online_panchayat_flutter/screens/find_professionals_screen.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfessionalTile extends StatelessWidget {
  Professional professional;
  Location myLocation;
  NumberFormat f = NumberFormat('#######0.##');
  ProfessionalTile({Key key, this.professional, this.myLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool showPopupMenu =
        (Provider.of<GlobalDataNotifier>(context, listen: false).localUser.id ==
                '+91${professional.contactNo}' ||
            professional.contactNo == 1234567890);
    return Padding(
      padding: getPostWidgetSymmetricPadding(
        context,
        horizontal: 0,
        vertical: 0.0,
      ),
      child: InkWell(
        onTap: () => context.vxNav.push(Uri.parse(MyRoutes.viewProfessional),
            params: [professional, myLocation]),
        //                  Navigator.of(context).push(CupertinoPageRoute(
        // builder: (_) => IndividualProfessionalScreen(
        //       professional: professional,
        //       myLocation: myLocation,
        //     ))),
        child: Card(
          color: Theme.of(context).cardColor,
          shadowColor: Theme.of(context).shadowColor,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                    flex: 1,
                    child: CircleAvatar(
                        backgroundImage:
                            Image.network(professional.imageUrl ?? APP_ICON_URL)
                                .image)),
                SizedBox(
                  width: context.safePercentWidth * 2.5,
                ),
                Flexible(
                  flex: showPopupMenu ? 5 : 6,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${capitalise(professional.name)}',
                          style: Theme.of(context).textTheme.headline2.copyWith(
                              fontSize: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.m10),
                              fontWeight: FontWeight.w400),
                        ),
                        (professional.descripton == null)
                            ? Container()
                            : Text(
                                '${capitalise(professional.descripton)}',
                                style: TextStyle(
                                  color: lightGreySubheading,
                                  fontWeight: FontWeight.normal,
                                  fontSize: responsiveFontSize(context,
                                      size: ResponsiveFontSizes.xs),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: context.safePercentWidth * 2.5,
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          AnalyticsService.firebaseAnalytics
                              .logEvent(name: "call_professional", parameters: {
                            "professional_phone_number": professional.contactNo,
                            "profession": professional.profession,
                            "professional_name": professional.name,
                            "caller_id":
                                Services.globalDataNotifier.localUser.id,
                          });
                          launch('tel:${professional.contactNo}');
                        },
                        icon: Icon(
                          Icons.phone,
                          size: responsiveFontSize(context,
                              size: ResponsiveFontSizes.m10),
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        '${f.format(Geolocator.distanceBetween(myLocation.lat, myLocation.lon, professional.point.location.lat, professional.point.location.lon) / 1000.0)} ${KMS.tr()}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: lightGreySubheading,
                          fontWeight: FontWeight.normal,
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.xs),
                        ),
                      ).tr(),
                    ],
                  ),
                ),
                showPopupMenu
                    ? Flexible(
                        child: PopupMenuButton<PopUpMenuOption>(
                          onSelected: (option) {
                            print('$option selected');

                            switch (option) {
                              case PopUpMenuOption.Edit:
                                Navigator.of(context)
                                    .push(CupertinoPageRoute(
                                        builder: (_) =>
                                            RegisterProfessionalScreen(
                                              professional: professional,
                                            )))
                                    .then((value) {
                                  Provider.of<IndividualProfessionalListScreenData>(
                                          context,
                                          listen: false)
                                      .updateProfessional(professional);
                                });
                                break;

                              case PopUpMenuOption.Delete:
                                bool deletionSuccessful = true;

                                try {
                                  Provider.of<IndividualProfessionalListScreenData>(
                                          context,
                                          listen: false)
                                      .removeProfessional(professional);
                                } catch (e, s) {
                                  deletionSuccessful = false;
                                  FirebaseCrashlytics.instance
                                      .recordError(e, s);
                                }
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    (deletionSuccessful)
                                        ? PROFESSIONAL_DELETION_SUCCESSFUL
                                        : PROFESSIONAL_DELETION_FAILED,
                                  ).tr(),
                                ));
                                break;
                            }
                          },
                          itemBuilder: (_) => [
                            PopupMenuItem(
                              value: PopUpMenuOption.Edit,
                              child: Text(
                                EDIT.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: responsiveFontSize(context,
                                          size: ResponsiveFontSizes.s),
                                    ),
                              ),
                            ),
                            PopupMenuItem(
                              value: PopUpMenuOption.Delete,
                              child: Text(
                                DELETE.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: responsiveFontSize(context,
                                          size: ResponsiveFontSizes.s),
                                    ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum PopUpMenuOption { Edit, Delete }
