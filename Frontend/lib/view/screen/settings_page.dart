import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/localization/changelocal.dart';
import 'package:companymanagment/view/widget/language/custombuttonlang.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LocalController localController = Get.find();
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr),
      ),
      body: ListView(
        padding: EdgeInsets.all(scale.scale(16)),
        children: [
          Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.all(scale.scale(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'language_settings'.tr,
                    style: theme.textTheme.titleLarge
                        ?.copyWith(color: theme.colorScheme.primary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'choose_display_language'.tr,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 20),
                  Custombuttonlang(
                    textbutton: "English",
                    onPressed: () {
                      localController.changeLang("en");
                    },
                  ),
                  const SizedBox(height: 12),
                  Custombuttonlang(
                    textbutton: "العربية",
                    onPressed: () {
                      localController.changeLang("ar");
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
