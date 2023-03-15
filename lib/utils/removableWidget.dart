// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class RemovableWidget extends StatelessWidget {
  final Widget child;
  final Function onRemoved;
  RemovableWidget({@required this.child, @required this.onRemoved});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          right: 2,
          top: 2,
          child: InkWell(
            onTap: onRemoved,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                Icons.cancel,
                // color: Theme.of(context).textTheme.headline1.color,
                color: Colors.red,
              ),
            ),
          ),
        )
      ],
    );
  }
}
