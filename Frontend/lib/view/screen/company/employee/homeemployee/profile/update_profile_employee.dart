import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/employee/homeemployee/profile/updateprofileemployee_controller.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/widget/company/employee/home/profile/edit_able_field.dart';
import 'package:companymanagment/view/widget/company/employee/home/profile/update_image_section_profile.dart';

class UpdateProfileEmployeePage extends StatelessWidget {
  const UpdateProfileEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileUpdateEmployeeController controller =
        Get.put(ProfileUpdateEmployeeController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "219".tr,
          style: TextStyle(fontSize: context.scaleConfig.scaleText(20)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save, size: context.scaleConfig.scale(24)),
            onPressed: controller.saveProfile,
          ),
        ],
      ),
      body: GetBuilder<ProfileUpdateEmployeeController>(
        builder: (controller) => Padding(
          padding: EdgeInsets.all(context.scaleConfig.scale(16)),
          child: Column(
            children: [
              UpdateImageSectionProfile(),
              SizedBox(height: context.scaleConfig.scale(20)),
              EditAbleField(
                label: "215".tr, // Name
                controller: controller.nameController,
              ),
              SizedBox(height: context.scaleConfig.scale(12)),
              EditAbleField(
                label: "217".tr, // Phone
                controller: controller.phoneController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
