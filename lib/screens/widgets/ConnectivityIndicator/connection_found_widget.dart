// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'connection_status_widget.dart';

class ConnectionFoundWidget extends StatefulWidget {
  const ConnectionFoundWidget({Key key}) : super(key: key);

  @override
  State<ConnectionFoundWidget> createState() => _ConnectionFoundWidgetState();
}

class _ConnectionFoundWidgetState extends State<ConnectionFoundWidget> {
  double _size = 0.0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _increaseSize();
    });
    Future.delayed(Duration(seconds: 4)).then((value) => _reduceSize());
    super.initState();
  }

  void _reduceSize() {
    setState(() {
      _size = 0.0;
    });
  }

  void _increaseSize() {
    setState(() {
      _size = connectivityStatusWidgetSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConnectionStatusWidget(
      color: Colors.green,
      text: "Back online!",
      height: _size,
    );
  }
}
