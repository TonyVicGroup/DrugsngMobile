import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedPopupWidget extends StatelessWidget {
  const AnimatedPopupWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(child: child)
        .animate()
        .slide(
          begin: const Offset(0, 1),
          end: Offset.zero,
          duration: 400.ms,
          curve: Curves.easeOutCubic,
        )
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          duration: 300.ms,
          curve: Curves.easeOutBack,
          delay: 200.ms,
        )
        .then()
        .scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
          duration: 300.ms,
          curve: Curves.elasticOut,
          delay: 200.ms,
        );
    // .then()
    // .move(
    //   begin: const Offset(12, 0),
    //   end: const Offset(-12, 0),
    //   duration: 120.ms,
    //   curve: Curves.easeInOut,
    // )
    // .then()
    // .move(
    //   begin: const Offset(-12, 0),
    //   end: Offset.zero,
    //   duration: 60.ms,
    //   curve: Curves.easeInOut,
    // );
  }
}
