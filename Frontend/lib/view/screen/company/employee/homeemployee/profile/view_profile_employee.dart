import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/employee/homeemployee/profile/viewprofileemployee_controller.dart';
import 'package:tasknotate/core/class/handlingdataview.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/view/widget/company/employee/home/profile/field_section.dart';
import 'package:tasknotate/view/widget/company/employee/home/profile/view_image_section_profile.dart';

class ProfileEmployeePage extends StatelessWidget {
  const ProfileEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewProfileEmployeeController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "214".tr, // Profile
          style: TextStyle(fontSize: context.scaleConfig.scaleText(20)),
        ),
      ),
      body: GetBuilder<ViewProfileEmployeeController>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: Padding(
            padding: EdgeInsets.all(context.scaleConfig.scale(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ViewImageSectionProfile(),
                SizedBox(height: context.scaleConfig.scale(20)),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        FieldSection(
                          label: "215".tr, // Name
                          value: controller.userModel?.usersName ??
                              "318".tr, // N/A
                        ),
                        SizedBox(height: context.scaleConfig.scale(12)),
                        FieldSection(
                          label: "216".tr, // Email
                          value: controller.userModel?.usersEmail ??
                              "318".tr, // N/A
                        ),
                        SizedBox(height: context.scaleConfig.scale(12)),
                        FieldSection(
                          value: controller.userModel?.usersPhone?.toString() ??
                              "318".tr, // N/A,

                          label: "217".tr, // Phone,
                        ),
                        SizedBox(height: context.scaleConfig.scale(12)),
                        FieldSection(
                          label: "218".tr, // Role
                          value: "Can Change Later",
                        ),
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: controller.goToUpdateProfile,
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text(
                    "219".tr, // Edit Profile
                    style:
                        TextStyle(fontSize: context.scaleConfig.scaleText(16)),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: context.scaleConfig.scale(16)),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(context.scaleConfig.scale(8))),
                ),
                SizedBox(height: context.scaleConfig.scale(16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
