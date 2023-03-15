// ignore_for_file: implementation_imports

import 'package:flutter/material.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';

/// A widget which provides padding for professional profile sections
/// It provides even padding to all sections of professional profile
/// Requires a child widget
class ProfessionalProfileSectionWithPadding extends StatelessWidget {
  const ProfessionalProfileSectionWithPadding(
      {Key key, @required this.childWidget})
      : super(key: key);
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.safePercentWidth * 1.7),
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 0.0,
        child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: context.safePercentHeight * 1,
                horizontal: context.safePercentWidth * 2.3),
            child: childWidget),
      ),
    );
  }
}
