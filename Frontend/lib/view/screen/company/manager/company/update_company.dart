import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/crudcompany/updatecompany_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/view/widget/company/manager/company/shared/build_text_filed_company.dart';
import 'package:tasknotate/view/widget/company/manager/company/shared/button_company.dart';
import 'package:tasknotate/view/widget/company/manager/company/shared/worker_count_company.dart';
import 'package:tasknotate/view/widget/company/manager/company/shared/role_section_company.dart';
import 'package:tasknotate/view/widget/company/manager/company/shared/image_section_company.dart';
import 'package:tasknotate/view/widget/company/manager/company/updatecompany/show_delete_employee_company.dart';

class UpdateCompany extends StatelessWidget {
  const UpdateCompany({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UpdatecompanyController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back,
              color: context.appTheme.iconTheme.color,
              size: context.scaleConfig.scale(24)),
        ),
        title: Text(
          "204".tr, // Update Company
          style: context.appTheme.textTheme.titleLarge
              ?.copyWith(fontSize: context.scaleConfig.scaleText(20)),
        ),
      ),
      body: GetBuilder<UpdatecompanyController>(
        builder: (controller) => Form(
          key: controller.formstate,
          child: ListView(
            padding: EdgeInsets.all(context.scaleConfig.scale(20)),
            children: [
              BuildTextFiledCompany(
                controller: controller.companyname,
                label: "182".tr, // Company Name
                hint: "183".tr, // Enter company name
              ),
              SizedBox(height: context.scaleConfig.scale(20)),
              BuildTextFiledCompany(
                controller: controller.companynickid,
                label: "184".tr, // Company ID
                hint: "185".tr, // Enter company ID
              ),
              SizedBox(height: context.scaleConfig.scale(20)),
              BuildTextFiledCompany(
                controller: controller.companydescription,
                label: "186".tr, // Description
                hint: "187".tr, // Enter description
              ),
              SizedBox(height: context.scaleConfig.scale(20)),
              // Logo Image Picker
              ImageSectionCompany(controller),
              SizedBox(height: context.scaleConfig.scale(20)),
              // Company Role Dropdown
              RoleSectionCompany(
                controller: controller,
              ),
              SizedBox(height: context.scaleConfig.scale(20)),
              // Worker Count
              GetBuilder<UpdatecompanyController>(
                builder: (controller) => WorkerCountCompany(
                  controller: controller,
                ),
              ),
              SizedBox(height: context.scaleConfig.scale(20)),
              ShowDeleteEmployeeCompany(
                controller: controller,
              ),
              SizedBox(height: context.scaleConfig.scale(20)),

              // Update Button
              ButtonCompany(controller)
            ],
          ),
        ),
      ),
    );
  }
}
