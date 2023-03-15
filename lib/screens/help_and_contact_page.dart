// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use, unused_catch_clause

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_panchayat_flutter/constants/images.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/services/remoteConfigService.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';

class HelpAndContactPage extends StatefulWidget {
  @override
  _HelpAndContactPageState createState() => _HelpAndContactPageState();
}

class _HelpAndContactPageState extends State<HelpAndContactPage> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: getPageAppBar(
        context: context,
        text: HELP_AND_CONTACT,
      ),
      body: Responsive(
        mobile: ResponsiveHelpAndContactPage(
          themeProvider: themeProvider,
        ),
        tablet: ResponsiveHelpAndContactPage(
          themeProvider: themeProvider,
        ),
        desktop: ResponsiveHelpAndContactPage(
          themeProvider: themeProvider,
        ),
      ),
    );
  }
}

class ResponsiveHelpAndContactPage extends StatelessWidget {
  final ThemeProvider themeProvider;
  final String appPackageName = "com.panchayat.online";

  const ResponsiveHelpAndContactPage({Key key, @required this.themeProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (RemoteConfigService.contact_information == null) {
      return Center(
        child: Text("error"),
      );
    }
    return Container(
      constraints: BoxConstraints.expand(),
      // color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: getPostWidgetSymmetricPadding(
            context,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ContactInfo(
                heading: PHONE_NUMBER,
                body: RemoteConfigService.contact_information["phone_number"],
                onTap: () {
                  launchInBrowser(Uri(
                    scheme: 'tel',
                    path: RemoteConfigService
                        .contact_information["phone_number"]
                        .toString(),
                  ).toString());
                },
                widget: Icon(
                  Icons.phone,
                  color: Colors.blue[500],
                  size: 40.0,
                ),
              ),
              ContactInfo(
                heading: EMAIL,
                body: RemoteConfigService.contact_information["email"],
                onTap: () {
                  launchInBrowser(Uri(
                    scheme: 'mailto',
                    path: RemoteConfigService.contact_information["email"]
                        .toString(),
                  ).toString());
                },
                widget: Icon(
                  Icons.mail,
                  color: Colors.red[500],
                  size: 40.0,
                ),
              ),
              ContactInfo(
                  heading: WHATSAPP_NUMBER,
                  body: RemoteConfigService
                      .contact_information["whatsapp_number"],
                  onTap: () async {
                    if (await canLaunch(
                        "whatsapp://send?phone=${RemoteConfigService.contact_information["whatsapp_number"]}")) {
                      await launch(
                        "whatsapp://send?phone=${RemoteConfigService.contact_information["whatsapp_number"]}",
                        forceSafariVC: false,
                        forceWebView: false,
                        headers: <String, String>{
                          'my_header_key': 'my_header_value'
                        },
                      );
                    } else {
                      throw 'Could not launch ';
                    }
                  },
                  widget: Image(
                    image: AssetImage(whatsapp),
                    height: 40,
                  )),
              ContactInfo(
                  heading: PLAYSTORE,
                  body: PLAYSTORE_DESCRIPTION.tr(),
                  onTap: () async {
                    try {
                      launch("market://details?id=" + appPackageName);
                    } on PlatformException catch (e) {
                      launch("https://play.google.com/store/apps/details?id=" +
                          appPackageName);
                    } finally {
                      launch("https://play.google.com/store/apps/details?id=" +
                          appPackageName);
                    }
                  },
                  widget: Image(
                    image: AssetImage(playstore),
                    height: 40,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactInfo extends StatelessWidget {
  final String heading;
  final String body;
  final Widget widget;
  final Function onTap;

  const ContactInfo({
    Key key,
    @required this.heading,
    @required this.body,
    this.widget,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: Theme.of(context).textTheme.headline2.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s)),
                  ).tr(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    body,
                    style: Theme.of(context).textTheme.headline2.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.m)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            widget != null
                ? Flexible(
                    child: InkWell(
                      child: widget,
                      onTap: onTap,
                    ),
                  )
                : Container(),
          ],
        ),
        Divider(
          color: Theme.of(context).textTheme.headline2.color,
          height: 0.8,
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
