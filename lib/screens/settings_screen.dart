// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use

import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart' as constants;
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: getPageAppBar(
        context: context,
        text: SETTINGS,
      ),
      body: Responsive(
        mobile: ResponsiveSettings(
          themeProvider: themeProvider,
        ),
        tablet: ResponsiveSettings(
          themeProvider: themeProvider,
        ),
        desktop: ResponsiveSettings(
          themeProvider: themeProvider,
        ),
      ),
    );
  }
}

class ResponsiveSettings extends StatelessWidget {
  final ThemeProvider themeProvider;

  const ResponsiveSettings({Key key, @required this.themeProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLocaleEnglish = UtilityService.getCurrentLocale(context) == "en_US";
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    THEME,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.m)),
                  ).tr(),
                  DayNightSwitcherIcon(
                      isDarkModeEnabled: themeProvider.isDarkModeEnabled,
                      onStateChanged: (bool state) {
                        themeProvider.swapTheme();
                      })
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  CHANGE_LANGUAGE,
                  style: Theme.of(context).textTheme.headline1.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.m)),
                ).tr(),
              ),
              SizedBox(
                height: 5,
              ),
              CustomButton(
                  text: isLocaleEnglish ? "हिंदी" : "English",
                  autoSize: true,
                  buttonColor: constants.maroonColor,
                  onPressed: () async {
                    await context.setLocale(
                        isLocaleEnglish ? Locale('hi') : Locale('en', 'US'));
                    themeProvider.notifyThemeProviderListeners();
                  }),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
