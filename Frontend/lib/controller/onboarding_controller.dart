import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/services/services.dart';
import 'package:tasknotate/data/datasource/static/static.dart';
import 'package:tasknotate/controller/theme_controller.dart';
import 'package:tasknotate/core/localization/changelocal.dart';

abstract class OnboardingController extends GetxController {
  next();
  onPageChanged(int index);
}

class OnBoardingControllerImp extends OnboardingController {
  late PageController pageController;
  int currentpage = 0;
  MyServices myServices = Get.find();

  @override
  next() {
    currentpage++;
    if (currentpage > onBoardingList.length - 1) {
      myServices.sharedPreferences.setString("step", "1");
      Get.offAllNamed(AppRoute.home);
    } else {
      pageController.animateToPage(
        currentpage,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  onPageChanged(int index) {
    currentpage = index;
    update();
  }

  @override
  void onInit() {
    // Initialize controllers
    Get.put(ThemeController());
    Get.put(LocalController());
    pageController = PageController();
    super.onInit();
  }
}
