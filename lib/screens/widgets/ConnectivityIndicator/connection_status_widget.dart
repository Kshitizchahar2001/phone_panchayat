// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

const double connectivityStatusWidgetSize = 30;

class ConnectionStatusWidget extends StatelessWidget {
  final Color color;
  final String text;
  final double height;
  const ConnectionStatusWidget({
    Key key,
    @required this.color,
    @required this.text,
    this.height = connectivityStatusWidgetSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: AnimatedSize(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        alignment: Alignment.center,
        child: SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 2.0,
              horizontal: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
