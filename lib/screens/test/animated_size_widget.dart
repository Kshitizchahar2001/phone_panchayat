import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/widgets/ConnectivityIndicator/connection_status_widget.dart';

class MyAnimatedSizeWidget extends StatefulWidget {
  const MyAnimatedSizeWidget({Key key}) : super(key: key);

  @override
  State<MyAnimatedSizeWidget> createState() => _MyAnimatedSizeWidgetState();
}

class _MyAnimatedSizeWidgetState extends State<MyAnimatedSizeWidget> {
  double _size = 50.0;
  bool _large = false;

  void _updateSize() {
    setState(() {
      _size = _large ? 50.0 : 10.0;
      _large = !_large;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => _updateSize(),
          child: ConnectionStatusWidget(
            color: Colors.green,
            text: 'test',
            height: _size,
          ),
        ),
      ),
    );
  }
}
