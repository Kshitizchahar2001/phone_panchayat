import 'package:flutter/material.dart';

import 'connection_status_widget.dart';

class NoConnectionWidget extends StatefulWidget {
  const NoConnectionWidget({Key key}) : super(key: key);

  @override
  State<NoConnectionWidget> createState() => _NoConnectionWidgetState();
}

class _NoConnectionWidgetState extends State<NoConnectionWidget> {
  double _size = 0.0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _increaseSize();
    });

    super.initState();
  }

  void _increaseSize() {
    setState(() {
      _size = connectivityStatusWidgetSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConnectionStatusWidget(
      color: Colors.red,
      text: "No Connection",
      height: _size,
    );
  }
}
