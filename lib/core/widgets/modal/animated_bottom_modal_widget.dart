import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class AnimatedBottomModalWidget extends StatefulWidget {
  const AnimatedBottomModalWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<AnimatedBottomModalWidget> createState() =>
      _AnimatedBottomModalWidgetState();
}

class _AnimatedBottomModalWidgetState extends State<AnimatedBottomModalWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.02,
    );
    _slideAnimation = _controller.drive(
      Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero),
    );
    _controller.animateWith(
      SpringSimulation(
        const SpringDescription(mass: 1.0, stiffness: 200.0, damping: 12.0),
        0.0,
        1.0,
        0.0,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: widget.child,
      ),
    );
  }
}
