import 'package:companymanagment/view/widget/language/navigation_controls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/onboarding_controller.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/widget/onboarding/customslider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final OnBoardingControllerImp controller =
        Get.put(OnBoardingControllerImp());
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Scaffold(
      // The background is now the standard app background, not the primary color.
      backgroundColor: theme.colorScheme.background,
      body: Stack(
        children: [
          // This widget now contains both the blue background and the image.
          const CustomSliderOnBoarding(),

          // Bottom white card with content and navigation
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Get.height * 0.45,
              width: double.infinity,
              padding: EdgeInsets.all(scale.scale(24)),
              decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, -10))
                  ]),
              child: GetBuilder<OnBoardingControllerImp>(builder: (logic) {
                return const OnboardingNavigationControls();
              }),
            ),
          ),

          // Skip Button, now placed safely within a SafeArea.
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(scale.scale(8.0)),
                child: TextButton(
                  onPressed: controller.skip,
                  child: Text(
                    "skip".tr,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.white70),
                  ),
                ),
              ),
            ),
          ).animate().fade(delay: 500.ms),
        ],
      ),
    );
  }
}
