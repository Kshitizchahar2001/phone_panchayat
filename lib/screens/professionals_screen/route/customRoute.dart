// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class CustomRoute extends Page {
  final Widget child;

  CustomRoute({@required this.child}) : super();

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SlideTransition(
          position: Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
              .animate(animation),
          child: child,
        );
      },
    );
  }
}
