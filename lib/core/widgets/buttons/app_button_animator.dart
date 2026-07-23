import 'package:flutter/material.dart';

class AppButtonAnimator extends StatefulWidget {
  const AppButtonAnimator({
    required this.onTap,
    required this.child,
    this.enabled = true,
    this.animationOffset = 0.92,

    super.key,
  });
  final bool enabled;
  final VoidCallback onTap;
  final Widget child;
  final double animationOffset;

  @override
  _AppButtonAnimatorState createState() => _AppButtonAnimatorState();
}

class _AppButtonAnimatorState extends State<AppButtonAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1, end: widget.animationOffset).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticIn,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (widget.enabled) {
      await _animationController.forward().then((_) {
        _animationController.reverse();
      });
      widget.onTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: widget.enabled ? _handleTap : null,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
