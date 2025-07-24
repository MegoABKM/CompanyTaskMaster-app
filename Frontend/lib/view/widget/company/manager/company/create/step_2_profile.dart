import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/crudcompany/createcompany_controller.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/widget/company/manager/company/shared/image_section_company.dart';
import 'package:companymanagment/view/widget/company/manager/company/shared/role_section_company.dart';

class StepProfile extends GetView<CreatecompanyController> {
  const StepProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = context.scaleConfig;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: scale.scale(24)),
      children: [
        Text(
          "376".tr, // Company Profile
          style: context.textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: scale.scale(8)),
        Text(
          "customize_your_identity".tr, // Add to translations
          style: context.textTheme.bodyLarge?.copyWith(
              color: context.theme.colorScheme.onSurface.withOpacity(0.6)),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: scale.scale(32)),
        ImageSectionCompany(controller),
        SizedBox(height: scale.scale(24)),
        RoleSectionCompany(controller: controller),
      ],
    );
  }
}
