// ignore_for_file: file_names, curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:online_panchayat_flutter/screens/widgets/ScrollToTop/upArrow.dart';

class ScrollToTop extends StatefulWidget {
  final double bottomPadding;
  final Widget child;
  final ScrollController scrollController;
  const ScrollToTop({
    Key key,
    @required this.child,
    @required this.scrollController,
    this.bottomPadding,
  }) : super(key: key);

  @override
  _ScrollToTopState createState() => _ScrollToTopState();
}

class _ScrollToTopState extends State<ScrollToTop>
    with SingleTickerProviderStateMixin {
  ValueNotifier<bool> _buttonNotifier;
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    _buttonNotifier = ValueNotifier(false);

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _buttonNotifier.addListener(_buttonListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _buttonNotifier.removeListener(_buttonListener);
    _buttonNotifier.dispose();
    super.dispose();
  }

  void _buttonListener() {
    if (_buttonNotifier.value == true) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        NotificationListener<ScrollNotification>(
          child: widget.child,
          onNotification: (notification) {
            if (notification is UserScrollNotification) {
              if (notification.direction == ScrollDirection.reverse) {
                //hide button
                if (_buttonNotifier.value == true)
                  _buttonNotifier.value = false;
              } else if (notification.direction == ScrollDirection.forward) {
                //show button
                if (_buttonNotifier.value == false)
                  _buttonNotifier.value = true;
              } else if (notification.direction == ScrollDirection.idle) {
                //show button
                if (widget.scrollController.position.pixels == 0.0 &&
                    _buttonNotifier.value == true)
                  _buttonNotifier.value = false;
              }
            }
            return false;
          },
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _offsetAnimation,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    widget.scrollController.animateTo(
                      widget.scrollController.position.minScrollExtent,
                      duration: Duration(seconds: 2),
                      curve: Curves.fastOutSlowIn,
                    );
                    _buttonNotifier.value = false;
                  },
                  child: UpArrow(bottomPadding: widget.bottomPadding),
                ),
              ),
            ))
      ],
    );
  }
}
