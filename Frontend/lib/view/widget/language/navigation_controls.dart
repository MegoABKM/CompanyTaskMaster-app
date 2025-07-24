import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/onboarding_controller.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/widget/onboarding/dotcontroller.dart';

class OnboardingNavigationControls extends GetView<OnBoardingControllerImp> {
  const OnboardingNavigationControls({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return GetBuilder<OnBoardingControllerImp>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // The Text content is now here, inside the white card
          Text(
            controller.getCurrentTitle(),
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: scale.scale(16)),
          Text(
            controller.getCurrentBody(),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              height: 1.5,
            ),
          ),
          const Spacer(),
          // Combined navigation row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomDotControllerOnBoarding(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: scale.scale(24),
                    vertical: scale.scale(12),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(scale.scale(12)),
                  ),
                ),
                onPressed: controller.next,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      controller.currentpage == controller.pageCount - 1
                          ? "get_started".tr // Add to translations
                          : "next".tr,
                    ),
                    SizedBox(width: scale.scale(8)),
                    Icon(Icons.arrow_forward, size: scale.scale(20)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
