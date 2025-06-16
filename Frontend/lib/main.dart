import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/bindings/initialbinding.dart';
import 'package:tasknotate/controller/theme_controller.dart';
import 'package:tasknotate/core/localization/changelocal.dart';
import 'package:tasknotate/core/localization/translation.dart';
import 'package:tasknotate/core/services/app_security_service.dart';
import 'package:tasknotate/core/services/services.dart';
import 'package:tasknotate/routes.dart';
import 'package:tasknotate/view/screen/home_navigator.dart';

MyServices myServices = Get.find<MyServices>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await initialServices();
    print('Services initialized successfully');
  } catch (e) {
    print('Error initializing services: $e');
    return;
  }

  try {
    await MyTranslation.init();
  } catch (e) {
    print('Error loading translations: $e');
  }

  // Check cached app status
  final myServices = Get.find<MyServices>();
  final isEnabled =
      myServices.sharedPreferences.getBool('app_is_enabled') ?? true;

  Get.put(ThemeController());
  Get.put(LocalController());

  runApp(MyApp(isEnabled: isEnabled));
}

class MyApp extends StatelessWidget {
  final bool isEnabled;

  const MyApp({super.key, required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    final LocalController localController = Get.find();

    return GetBuilder<ThemeController>(
      builder: (_) => GetMaterialApp(
        translations: MyTranslation(),
        initialBinding: Initialbinding(),
        debugShowCheckedModeBanner: false,
        locale: localController.language,
        fallbackLocale: const Locale('en'),
        theme: themeController.currentTheme,
        getPages: routes,
        home: AppStartupScreen(isEnabled: isEnabled),
      ),
    );
  }
}

class AppStartupScreen extends StatelessWidget {
  final bool isEnabled;

  const AppStartupScreen({super.key, required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final securityService = Get.find<AppSecurityService>();
      final isAppEnabled =
          await securityService.checkAppStatus(forceCheck: true);
      if (!isAppEnabled) {}
    });

    if (isEnabled) {
      return const HomeNavigator();
    }

    return const Scaffold(
      body: Center(
        child: Text('Checking app status...'),
      ),
    );
  }
}
