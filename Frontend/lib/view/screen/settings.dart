import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/settings_controller.dart';
import 'package:tasknotate/controller/theme_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/core/localization/changelocal.dart';
import 'package:tasknotate/core/services/services.dart';
import 'package:tasknotate/view/widget/settings/change_language_card.dart';
import 'package:tasknotate/view/widget/settings/change_role_card.dart';
import 'package:tasknotate/view/widget/settings/disable_all_alarm_card.dart';
import 'package:tasknotate/view/widget/settings/sign_out_button.dart';
import 'package:tasknotate/view/widget/settings/theme_selection_main.dart';
import 'package:tasknotate/view/widget/settings/color_selection_card.dart';
import 'package:tasknotate/view/widget/settings/info_card.dart';
import 'package:tasknotate/view/widget/settings/support_card.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final MyServices myServices = Get.find();
    Get.put(SettingsController());
    Get.put(LocalController());
    Get.put(ThemeController());

    return GetBuilder<ThemeController>(
      builder: (themeController) => Scaffold(
        backgroundColor: context.appTheme.colorScheme.primary,
        appBar: AppBar(
          title: Text(
            '101'.tr,
            style: context.appTextTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: context.scaleConfig.scaleText(20).clamp(18, 24),
              color: context.appTheme.colorScheme.onPrimary,
            ),
          ),
          backgroundColor: context.appTheme.colorScheme.primary,
          elevation: 0,
        ),
        body: Container(
          color: context.appTheme.colorScheme.primary,
          padding: EdgeInsets.all(context.scaleConfig.scale(20).clamp(16, 24)),
          child: ListView(
            children: [
              ThemeSelectionMain(),
              SizedBox(height: context.scaleConfig.scale(16).clamp(12, 20)),
              ColorSelectionCard(),
              SizedBox(height: context.scaleConfig.scale(16).clamp(12, 20)),
              ChangeLanguageCard(),
              SizedBox(height: context.scaleConfig.scale(16).clamp(12, 20)),
              DisableAllAlarmCard(),
              if (myServices.sharedPreferences.getString('step') == "2") ...[
                SizedBox(height: context.scaleConfig.scale(16).clamp(12, 20)),
                ChangeRoleCard(),
              ],
              SizedBox(height: context.scaleConfig.scale(16).clamp(12, 20)),
              SupportCard(),
              SizedBox(height: context.scaleConfig.scale(16).clamp(12, 20)),
              InfoCard(),
              SizedBox(height: context.scaleConfig.scale(16).clamp(12, 20)),
              SignOutButton(),
              SizedBox(height: context.scaleConfig.scale(20).clamp(16, 24)),
            ],
          ),
        ),
      ),
    );
  }
}
