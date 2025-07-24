import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/onboarding_controller.dart';
import 'package:companymanagment/data/datasource/static/static.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class CustomSliderOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomSliderOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    // This container is the blue background for the top half.
    return Container(
      height: Get.height * 0.60, // Takes up the top 60% of the screen
      width: double.infinity,
      color: theme.colorScheme.primary,
      child: PageView.builder(
        controller: controller.pageController,
        onPageChanged: (value) {
          controller.onPageChanged(value);
        },
        itemCount: onBoardingList.length,
        itemBuilder: (context, index) {
          // The content of each page is centered.
          return Center(
            child: Container(
              width: Get.width * 0.75, // Image takes 75% of screen width
              height: Get.width * 0.75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(scale.scale(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 30,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(scale.scale(25)),
                child: Image.asset(
                  onBoardingList[index].image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
              .animate(key: ValueKey(index))
              .fade(duration: 600.ms)
              .scale(begin: const Offset(0.8, 0.8));
        },
      ),
    );
  }
}
