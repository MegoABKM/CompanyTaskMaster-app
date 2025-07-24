import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/crudcompany/createcompany_controller.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/widget/company/manager/company/shared/build_text_filed_company.dart';

class StepCoreInfo extends GetView<CreatecompanyController> {
  const StepCoreInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = context.scaleConfig;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: scale.scale(24)),
      children: [
        Text(
          "375".tr, // Basic Information
          style: context.textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: scale.scale(8)),
        Text(
          "tell_us_about_company".tr, // Add to translations
          style: context.textTheme.bodyLarge?.copyWith(
              color: context.theme.colorScheme.onSurface.withOpacity(0.6)),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: scale.scale(32)),
        BuildTextFiledCompany(
          controller: controller.companyname,
          label: "182".tr, // Company Name
          hint: "183".tr, // Enter company name
          icon: Icons.business,
          validator: (val) => val!.isEmpty ? "please_enter_value".tr : null,
        ),
        SizedBox(height: scale.scale(24)),
        BuildTextFiledCompany(
          controller: controller.companydescription,
          label: "186".tr, // Description
          hint: "187".tr, // Enter a short description
          icon: Icons.description_outlined,
          maxLines: 4,
          validator: (val) => val!.isEmpty ? "please_enter_value".tr : null,
        ),
      ],
    );
  }
}
