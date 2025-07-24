import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/crudcompany/updatecompany_controller.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';
import 'package:companymanagment/view/widget/company/manager/company/shared/build_text_filed_company.dart';
import 'package:companymanagment/view/widget/company/manager/company/shared/form_section_card.dart';
import 'package:companymanagment/view/widget/company/manager/company/shared/image_section_company.dart';
import 'package:companymanagment/view/widget/company/manager/company/shared/role_section_company.dart';
import 'package:companymanagment/view/widget/company/manager/company/shared/worker_count_company.dart';
import 'package:companymanagment/view/widget/company/manager/company/updatecompany/show_delete_employee_company.dart';
import 'package:flutter_animate/flutter_animate.dart';

class UpdateCompany extends StatelessWidget {
  const UpdateCompany({super.key});

  @override
  Widget build(BuildContext context) {
    // A binding should be used for this screen for consistency

    Get.put(UpdatecompanyController());
    final scale = context.scaleConfig;

    return Scaffold(
      appBar: AppBar(
        title: Text("204".tr), // Update Company
      ),
      body: GetBuilder<UpdatecompanyController>(
        builder: (controller) => Form(
          key: controller.formstate,
          child: ListView(
            padding: EdgeInsets.all(scale.scale(16)),
            children: [
              // Section 1: Basic Information
              FormSectionCard(
                title: "375".tr, // Basic Information
                children: [
                  BuildTextFiledCompany(
                    controller: controller.companyname,
                    label: "182".tr, // Company Name
                    hint: "183".tr, // Enter company name
                    icon: Icons.business,
                    validator: (val) =>
                        val!.isEmpty ? "please_enter_value".tr : null,
                  ),
                  SizedBox(height: scale.scale(16)),
                  // COMPANY ID IS NOW DISPLAY-ONLY
                  BuildTextFiledCompany(
                    controller: controller.companynickid,
                    label: "184".tr, // Company ID
                    hint: "This ID is auto-generated",
                    icon: Icons.vpn_key_outlined,
                    readOnly: true, // Make it non-editable
                  ),
                  SizedBox(height: scale.scale(16)),
                  BuildTextFiledCompany(
                    controller: controller.companydescription,
                    label: "186".tr, // Description
                    hint: "187".tr, // Enter a short description
                    icon: Icons.description_outlined,
                    maxLines: 3,
                    validator: (val) =>
                        val!.isEmpty ? "please_enter_value".tr : null,
                  ),
                ],
              ),

              // Section 2: Company Profile
              FormSectionCard(
                title: "376".tr, // Company Profile
                children: [
                  ImageSectionCompany(controller),
                  SizedBox(height: scale.scale(16)),
                  RoleSectionCompany(controller: controller),
                ],
              ),

              // Section 3: Company Size
              FormSectionCard(
                title: "377".tr, // Company Size
                children: [
                  WorkerCountCompany(controller: controller),
                ],
              ),

              // Section 4: Manage Employees (optional)
              if (controller.companyData?.employees?.isNotEmpty ?? false)
                FormSectionCard(
                  title: "378".tr, // Manage Employees
                  children: [
                    ShowDeleteEmployeeCompany(controller: controller),
                  ],
                ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: scale.scale(16)),
                child: CustomButtonAuth(
                  textbutton: "379".tr, // Save Changes
                  onPressed: () {
                    if (controller.formstate.currentState!.validate()) {
                      controller.updateData();
                    }
                  },
                ),
              ),
            ]
                .animate(interval: 80.ms)
                .fade(duration: 400.ms)
                .slideY(begin: 0.2),
          ),
        ),
      ),
    );
  }
}
