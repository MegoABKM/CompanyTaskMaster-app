import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tasknotate/controller/onboarding_controller.dart';
import 'package:tasknotate/controller/theme_controller.dart';
import 'package:tasknotate/core/constant/appthemes.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';
import 'package:tasknotate/core/localization/changelocal.dart';
import 'package:tasknotate/data/datasource/static/static.dart';

class CustomSliderOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomSliderOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    final theme = Theme.of(context);
    final localController = Get.find<LocalController>();

    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: (value) {
        controller.onPageChanged(value);
      },
      itemCount: onBoardingList.length,
      itemBuilder: (context, index) {
        return SingleChildScrollView(
          child: Directionality(
            textDirection: localController.language.languageCode == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: scaleConfig.scale(40)),
                  child: Text(
                    onBoardingList[index].title!.tr,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: scaleConfig.scaleText(24),
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                SizedBox(height: scaleConfig.scale(20)),
                Container(
                  width: Get.width * 0.8,
                  height: Get.height * 0.35,
                  child: LottieBuilder.asset(
                    onBoardingList[index].image!,
                    width: Get.width * 0.8,
                    height: Get.height * 0.35,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: scaleConfig.scale(20)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: scaleConfig.scale(20)),
                  child: Text(
                    onBoardingList[index].body!.tr,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      height: 1.5,
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                      fontSize: scaleConfig.scaleText(18),
                    ),
                  ),
                ),
                // Language Dropdown for "Choose your language" slide (index 0)
                if (index == 0) ...[
                  SizedBox(height: scaleConfig.scale(20)),
                  GetBuilder<LocalController>(
                    builder: (localController) => DropdownButton<String>(
                      value: localController.language.languageCode,
                      items: [
                        DropdownMenuItem(
                          value: 'en',
                          child: Text('english'.tr),
                        ),
                        DropdownMenuItem(
                          value: 'ar',
                          child: Text('arabic'.tr),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          localController.changeLang(value);
                        }
                      },
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: scaleConfig.scaleText(16),
                        color: theme.colorScheme.onSurface,
                      ),
                      dropdownColor: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(scaleConfig.scale(8)),
                    ),
                  ),
                ],
                // Theme Toggle for "Personalized Experience" slide (index 4)
                if (index == 4) ...[
                  SizedBox(height: scaleConfig.scale(20)),
                  GetBuilder<ThemeController>(
                    builder: (themeController) => SwitchListTile(
                      title: Text(
                        themeController.isDarkMode
                            ? 'dark_mode'.tr
                            : 'light_mode'.tr,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: scaleConfig.scaleText(16),
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      value: themeController.isDarkMode,
                      onChanged: (value) {
                        themeController.toggleTheme();
                      },
                      activeColor: theme.colorScheme.primary,
                    ),
                  ),
                ],
                // Color Selection for "Change Color" slide (index 5)
                if (index == 5) ...[
                  SizedBox(height: scaleConfig.scale(20)),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          scaleConfig.scale(20).clamp(15, 30)),
                    ),
                    elevation: scaleConfig.scale(8).clamp(5, 10),
                    color: theme.cardColor.withOpacity(0.9),
                    child: Padding(
                      padding:
                          EdgeInsets.all(scaleConfig.scale(20).clamp(15, 25)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '370'.tr, // Color Selection
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontSize: scaleConfig.scaleText(20).clamp(16, 22),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: scaleConfig.scale(16).clamp(10, 20)),
                          Text(
                            '371'.tr, // Color
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontSize: scaleConfig.scaleText(16).clamp(14, 18),
                            ),
                          ),
                          GetBuilder<ThemeController>(
                            builder: (themeController) {
                              final colorValue = AppThemes.availableColors
                                      .containsKey(
                                          themeController.primaryColorKey)
                                  ? themeController.primaryColorKey
                                  : 'deepTeal';
                              return DropdownButton<String>(
                                value: colorValue,
                                isExpanded: true,
                                items: AppThemes.availableColors.entries
                                    .map((entry) {
                                  return DropdownMenuItem<String>(
                                    value: entry.key,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: scaleConfig
                                              .scale(20)
                                              .clamp(15, 25),
                                          height: scaleConfig
                                              .scale(20)
                                              .clamp(15, 25),
                                          color: entry.value,
                                        ),
                                        SizedBox(
                                            width: scaleConfig
                                                .scale(10)
                                                .clamp(5, 15)),
                                        Text(
                                          entry.key.tr,
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                            fontSize: scaleConfig
                                                .scaleText(16)
                                                .clamp(14, 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    themeController.setPrimaryColor(newValue);
                                    themeController.setSecondaryColor(newValue);
                                  }
                                },
                                underline: Container(
                                  height: 2,
                                  color: theme.colorScheme.secondary,
                                ),
                                icon: Icon(
                                  Icons.color_lens,
                                  color: theme.iconTheme.color,
                                  size: scaleConfig.scale(24).clamp(20, 30),
                                ),
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontSize:
                                      scaleConfig.scaleText(16).clamp(14, 18),
                                ),
                                dropdownColor: theme.cardColor,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                SizedBox(height: scaleConfig.scale(20)),
              ],
            ),
          ),
        );
      },
    );
  }
}
