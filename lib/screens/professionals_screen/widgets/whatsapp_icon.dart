// ignore_for_file: implementation_imports, deprecated_member_use, avoid_print

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/Professional.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsappIcon extends StatelessWidget {
  const WhatsappIcon({Key key, @required this.professional}) : super(key: key);

  final Professional professional;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () async {
            AnalyticsService.firebaseAnalytics
                .logEvent(name: "sp_message_professional", parameters: {
              "professional_whatsapp_number": professional.whatsappNumber,
              "profession": professional.occupationName,
              "professional_id": professional.user.id,
              "caller_id": Services.globalDataNotifier.localUser.id,
            });

            String messageText =
                "Hello ${professional.user.name ?? professional.shopName}, I got your contact through Phone Panchayat. I would like to take services from you";
            String url =
                "https://wa.me/${professional.whatsappNumber}?text=$messageText";

            await canLaunch(url)
                ? await launch(url)
                : print("Cannot launch whatsapp");
          },
          icon: Icon(
            FontAwesomeIcons.whatsapp,
            size: responsiveFontSize(context, size: ResponsiveFontSizes.l),
            color: Colors.green,
          ),
        ),
        Text(
          WHATSAPP,
          style: Theme.of(context).textTheme.headline2.copyWith(
              fontSize: responsiveFontSize(
                context,
                size: ResponsiveFontSizes.xs,
              ),
              color: lightGreySubheading),
        ).tr(),
      ],
    );
  }
}
