import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/onboarding_controller.dart';
import 'package:tasknotate/view/widget/onboarding/custombutton.dart';
import 'package:tasknotate/view/widget/onboarding/customslider.dart';
import 'package:tasknotate/view/widget/onboarding/dotcontroller.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingControllerImp());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: CustomSliderOnBoarding(),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomDotControllerOnBoarding(),
                  SizedBox(height: Get.height * 0.02),
                  CustombuttonOnBoarding(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
