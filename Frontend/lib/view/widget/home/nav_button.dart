import 'package:flutter/material.dart';
import 'package:tasknotate/controller/home_controller.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';

class NavButton extends StatelessWidget {
  final HomeController controller;
  final int index;
  final IconData icon;
  final ScaleConfig scaleConfig;

  const NavButton({
    super.key,
    required this.controller,
    required this.index,
    required this.icon,
    required this.scaleConfig,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onTapBottom(index),
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final bool isSelected = controller.currentIndex == index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(scaleConfig.scale(5)),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey,
              size: scaleConfig.scale(30),
            ),
          );
        },
      ),
    );
  }
}
