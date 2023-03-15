// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ScaleTransitionAnimation extends StatefulWidget {
  final Widget child;
  const ScaleTransitionAnimation({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  State<ScaleTransitionAnimation> createState() =>
      _ScaleTransitionAnimationState();
}

/// This is the private State class that goes with ScaleTransitionAnimation.
/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _ScaleTransitionAnimationState extends State<ScaleTransitionAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
      lowerBound: 0.6,
      upperBound: 1.0,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
