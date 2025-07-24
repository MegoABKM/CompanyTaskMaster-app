import 'package:flutter/material.dart';
import 'dart:ui';

class AnimatedAuroraBackground extends StatefulWidget {
  const AnimatedAuroraBackground({super.key});

  @override
  State<AnimatedAuroraBackground> createState() =>
      _AnimatedAuroraBackgroundState();
}

class _AnimatedAuroraBackgroundState extends State<AnimatedAuroraBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 20),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<Alignment> _topAlignmentAnimation = Tween<Alignment>(
    begin: Alignment.topLeft,
    end: Alignment.topRight,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine));

  late final Animation<Alignment> _bottomAlignmentAnimation = Tween<Alignment>(
    begin: Alignment.bottomRight,
    end: Alignment.bottomLeft,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [Color(0xFF302B63), Color(0xFF0F0C29)],
              begin: _topAlignmentAnimation.value,
              end: _bottomAlignmentAnimation.value,
            ),
          ),
        );
      },
    );
  }
}
