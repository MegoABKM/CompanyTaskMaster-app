import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/homemanager/profile.dart/updateprofilemanager_controller.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';
import 'package:companymanagment/view/widget/company/manager/company/shared/build_text_filed_company.dart';
import 'package:flutter_animate/flutter_animate.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileUpdateManagerController());
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Scaffold(
      appBar: AppBar(
        title: Text('219'.tr), // Edit Profile
        actions: [
          // The save button is now at the bottom for better ergonomics
        ],
      ),
      body: GetBuilder<ProfileUpdateManagerController>(
        builder: (controller) => ListView(
          padding: EdgeInsets.all(scale.scale(16)),
          children: [
            // --- Image Picker Section ---
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: scale.scale(60),
                    backgroundColor: theme.dividerColor,
                    backgroundImage: controller.pickedImage != null
                        ? FileImage(File(controller.pickedImage!.path))
                        : (controller.imageUrl != null &&
                                controller.imageUrl!.isNotEmpty)
                            ? NetworkImage(controller
                                .getCompanyImageUrl(controller.imageUrl!))
                            : null,
                    child: (controller.pickedImage == null &&
                            (controller.imageUrl == null ||
                                controller.imageUrl!.isEmpty))
                        ? Icon(Icons.person,
                            size: scale.scale(70), color: Colors.grey[400])
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Material(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: controller.pickImage,
                        child: Padding(
                          padding: EdgeInsets.all(scale.scale(8)),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: scale.scale(20),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: scale.scale(32)),

            // --- Form Fields ---
            BuildTextFiledCompany(
              label: '215'.tr, // Name
              hint: 'enter_new_name'.tr, // Add to translations
              controller: controller.nameController,
              icon: Icons.person_outline,
            ),
            SizedBox(height: scale.scale(24)),
            BuildTextFiledCompany(
              label: '217'.tr, // Phone
              hint: 'enter_new_phone'.tr, // Add to translations
              controller: controller.phoneController,
              icon: Icons.phone_outlined,
            ),
            SizedBox(height: scale.scale(40)),

            // --- Save Button ---
            CustomButtonAuth(
              textbutton: '379'.tr, // Save Changes
              onPressed: controller.saveProfile,
            ),
          ].animate(interval: 80.ms).fade(duration: 400.ms).slideY(begin: 0.2),
        ),
      ),
    );
  }
}
