// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

class Loading extends StatelessWidget {
  const Loading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MaterialApp(
          themeMode: themeProvider.getThemeMode,
          theme: themeProvider.light,
          darkTheme: themeProvider.dark,
          debugShowCheckedModeBanner: false,
          home: Scaffold(body: Center(child: CircularProgressIndicator())));
    });
  }
}
