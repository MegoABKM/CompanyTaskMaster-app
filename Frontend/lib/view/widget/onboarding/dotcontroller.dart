import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/onboarding_controller.dart';
import 'package:companymanagment/core/constant/utils/scale_confige.dart';
import 'package:companymanagment/data/datasource/static/static.dart';

class CustomDotControllerOnBoarding extends StatelessWidget {
  const CustomDotControllerOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    final theme = Theme.of(context);

    return GetBuilder<OnBoardingControllerImp>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            onBoardingList.length,
            (index) => AnimatedContainer(
              margin: EdgeInsets.only(right: scaleConfig.scale(8)),
              duration: const Duration(milliseconds: 300),
              width: controller.currentpage == index
                  ? scaleConfig.scale(20)
                  : scaleConfig.scale(8),
              height: scaleConfig.scale(8),
              decoration: BoxDecoration(
                color: controller.currentpage == index
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withOpacity(0.5),
                borderRadius: BorderRadius.circular(scaleConfig.scale(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
