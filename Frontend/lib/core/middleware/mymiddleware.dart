import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/constant/routes.dart';
import 'package:companymanagment/core/services/services.dart';

class Mymiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    MyServices myServices = Get.find();

    final bool langChosen =
        myServices.sharedPreferences.getBool("lang_chosen") ?? false;
    if (!langChosen) {
      if (route == AppRoute.language) {
        return null;
      }
      return const RouteSettings(name: AppRoute.language);
    }

    final String? step = myServices.sharedPreferences.getString("step");

    if (step == "3") {
      final String? userRole =
          myServices.sharedPreferences.getString("userrole");
      if (userRole == "manager") {
        if (route == AppRoute.managerhome) return null; // Already there
        return const RouteSettings(name: AppRoute.managerhome);
      }
      if (userRole == "employee") {
        if (route == AppRoute.employeehome) return null; // Already there
        return const RouteSettings(name: AppRoute.employeehome);
      }
    }

    if (step == "2") {
      if (route == AppRoute.companyhome) return null; // Already there
      return const RouteSettings(name: AppRoute.companyhome);
    }

    if (step == "1") {
      if (route == AppRoute.login) return null; // Already there
      return const RouteSettings(name: AppRoute.login);
    }

    if (route == AppRoute.onBoarding) return null; // Already there
    return const RouteSettings(name: AppRoute.onBoarding);
  }
}
