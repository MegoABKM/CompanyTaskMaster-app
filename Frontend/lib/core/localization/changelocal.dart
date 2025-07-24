import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/services/services.dart';
import 'package:companymanagment/controller/theme_controller.dart';

class LocalController extends GetxController {
  late Locale language;
  final MyServices myServices = Get.find<MyServices>();

  @override
  void onInit() {
    super.onInit();
    String? sharedprefLang = myServices.sharedPreferences.getString("lang");

    if (sharedprefLang == "ar") {
      language = const Locale("ar");
    } else if (sharedprefLang == "en") {
      language = const Locale("en");
    } else {
      language = Locale(Get.deviceLocale?.languageCode ?? "en");
    }
  }

  void changeLang(String lang) {
    language = Locale(lang);
    // SAVE THE LANGUAGE CHOICE
    myServices.sharedPreferences.setString("lang", lang);
    // SAVE THE FLAG THAT A LANGUAGE HAS BEEN CHOSEN
    myServices.sharedPreferences.setBool("lang_chosen", true);

    ThemeController themeController = Get.find<ThemeController>();
    themeController.updateThemeWithNewLanguage();

    Get.updateLocale(language);
    // After choosing a language, navigate to the OnBoarding screen
  }
}
