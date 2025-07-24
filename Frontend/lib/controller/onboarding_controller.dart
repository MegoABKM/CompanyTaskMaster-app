import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/constant/routes.dart';
import 'package:companymanagment/core/services/services.dart';
import 'package:companymanagment/data/datasource/static/static.dart';

abstract class OnboardingController extends GetxController {
  next();
  onPageChanged(int index);
  skip();
}

class OnBoardingControllerImp extends OnboardingController {
  late PageController pageController;
  int currentpage = 0;
  MyServices myServices = Get.find();

  int get pageCount => onBoardingList.length;

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  @override
  onPageChanged(int index) {
    currentpage = index;
    update(); // This notifies GetBuilders to rebuild
  }

  @override
  next() {
    // If we are on the last page, complete the onboarding
    if (currentpage >= pageCount - 1) {
      _completeOnboarding();
    } else {
      // Otherwise, go to the next page
      currentpage++;
      pageController.animateToPage(
        currentpage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  skip() {
    _completeOnboarding();
  }

  void _completeOnboarding() {
    myServices.sharedPreferences.setString("step", "1");
    Get.offAllNamed(AppRoute.login);
  }

  String getCurrentTitle() {
    if (currentpage < pageCount) {
      return onBoardingList[currentpage].title!;
    }
    return "";
  }

  String getCurrentBody() {
    if (currentpage < pageCount) {
      return onBoardingList[currentpage].body!;
    }
    return "";
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
