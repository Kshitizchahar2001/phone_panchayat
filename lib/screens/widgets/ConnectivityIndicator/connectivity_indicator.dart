// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/connectivityStatus.dart';
import 'package:online_panchayat_flutter/services/connectivityService.dart';
import 'package:provider/provider.dart';

import 'connection_found_widget.dart';
import 'no_connection_widget.dart';

class ConnectivityIndicatorWidget extends StatefulWidget {
  const ConnectivityIndicatorWidget({Key key}) : super(key: key);

  @override
  State<ConnectivityIndicatorWidget> createState() =>
      _ConnectivityIndicatorWidgetState();
}

class _ConnectivityIndicatorWidgetState
    extends State<ConnectivityIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityService>(
      builder: (context, value, child) {
        if (value.connectivityStatus == ConnectivityStatus.Offline)
          return NoConnectionWidget();
        if (value.oldConnectivityStatus == ConnectivityStatus.Offline &&
            value.connectivityStatus != ConnectivityStatus.Offline)
          return ConnectionFoundWidget();
        return Container();
      },
    );
  }
}
