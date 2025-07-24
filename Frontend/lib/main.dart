import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/bindings/initialbinding.dart';
import 'package:companymanagment/controller/theme_controller.dart';
import 'package:companymanagment/core/localization/changelocal.dart';
import 'package:companymanagment/core/localization/translation.dart';
import 'package:companymanagment/core/services/services.dart';
import 'package:companymanagment/routes.dart';
// ** STEP 1: IMPORT THE PACKAGE **
import 'package:intl/date_symbol_data_local.dart';

late MyServices myServices;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> _initialize() async {
    await initialServices();
    myServices = Get.find<MyServices>();
    await MyTranslation.init();

    // ** STEP 2: ADD THE INITIALIZATION CALL HERE **
    // This ensures date formatting is ready before any widget needs it.
    String initialLocale = Get.deviceLocale?.languageCode ?? 'en';
    String? savedLang = myServices.sharedPreferences.getString("lang");
    await initializeDateFormatting(savedLang ?? initialLocale, null);

    Get.put(LocalController());
    Get.put(ThemeController());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialize(),
      builder: (context, snapshot) {
        // ... The rest of this file remains unchanged ...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text(
                  'Initialization Error: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

        final LocalController localController = Get.find();
        final ThemeController themeController = Get.find();

        return GetBuilder<ThemeController>(
          builder: (_) => GetMaterialApp(
            initialBinding: Initialbinding(),
            translations: MyTranslation(),
            locale: localController.language,
            fallbackLocale: const Locale('en'),
            theme: themeController.currentTheme,
            debugShowCheckedModeBanner: false,
            getPages: routes,
          ),
        );
      },
    );
  }
}
