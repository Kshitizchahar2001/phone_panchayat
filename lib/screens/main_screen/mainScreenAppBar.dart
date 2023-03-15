// ignore_for_file: file_names, unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/DesignatedUserType.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:velocity_x/velocity_x.dart';

class MainScreenAppBarTitle extends StatefulWidget {
  const MainScreenAppBarTitle({
    Key key,
  }) : super(key: key);

  @override
  _MainScreenAppBarTitleState createState() => _MainScreenAppBarTitleState();
}

class _MainScreenAppBarTitleState extends State<MainScreenAppBarTitle> {
  int currentPage;
  int page;
  String panchayatNameInHindi;
  String locale;
  TextStyle appBarTextStyle;

  @override
  Widget build(BuildContext context) {
    appBarTextStyle = TextStyle(
      fontSize: 15,
      color: maroonColor,
    );

    return Consumer<GlobalDataNotifier>(
      builder: (context, value, child) {
        return Text(
          value.localUser?.area?.toString(),
          style: appBarTextStyle,
        );
      },
    );
  }

  // String getPanchayatName(String text) {
  //   locale = "hi";
  //   // locale = UtilityService.getCurrentLocale(context);
  //   print("locale is " + locale);
  //   if (locale == 'hi' && panchayatNameInHindi == null) getHindi(text);
  //   return (locale == "hi" && panchayatNameInHindi != null)
  //       ? panchayatNameInHindi
  //       : text;
  // }

}
