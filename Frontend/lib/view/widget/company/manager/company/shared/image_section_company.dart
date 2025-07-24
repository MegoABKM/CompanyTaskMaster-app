import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class ImageSectionCompany extends StatelessWidget {
  final dynamic controller;
  const ImageSectionCompany(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "188".tr, // Upload Company Logo
          style: context.appTheme.textTheme.titleMedium
              ?.copyWith(fontSize: context.scaleConfig.scaleText(18)),
        ),
        SizedBox(height: context.scaleConfig.scale(10)),
        InkWell(
          onTap: () => controller.pickImage(),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(context.scaleConfig.scale(10))),
            child: Container(
              height: context.scaleConfig.scale(150),
              decoration: BoxDecoration(
                color: context.appTheme.colorScheme.primaryContainer,
                borderRadius:
                    BorderRadius.circular(context.scaleConfig.scale(10)),
              ),
              child: controller.logoImage == null
                  ? Center(
                      child: Text(
                        "189".tr, // Tap to pick logo
                        style: context.appTheme.textTheme.bodyMedium?.copyWith(
                            fontSize: context.scaleConfig.scaleText(16)),
                      ),
                    )
                  : ClipRRect(
                      borderRadius:
                          BorderRadius.circular(context.scaleConfig.scale(10)),
                      child:
                          Image.file(controller.logoImage!, fit: BoxFit.cover),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
