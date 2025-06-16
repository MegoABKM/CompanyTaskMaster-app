import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/homemanager/profile.dart/updateprofilemanager_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileUpdateManagerController controller =
        Get.put(ProfileUpdateManagerController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '219'.tr, // Edit Profile
          style: TextStyle(fontSize: context.scaleConfig.scaleText(20)),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save, size: context.scaleConfig.scale(24)),
            onPressed: () => controller.saveProfile(),
          ),
        ],
      ),
      body: GetBuilder<ProfileUpdateManagerController>(
        builder: (controller) => Padding(
          padding: EdgeInsets.all(context.scaleConfig.scale(16)),
          child: Column(
            children: [
              GestureDetector(
                onTap: controller.pickImage,
                child: Center(
                  child: ClipOval(
                    child: controller.pickedImage != null
                        ? Image.file(
                            File(controller.pickedImage!.path),
                            width: context.scaleConfig.scale(120),
                            height: context.scaleConfig.scale(120),
                            fit: BoxFit.cover,
                          )
                        : controller.userModel?.usersImage != null &&
                                controller.userModel?.usersImage != ''
                            ? Image.network(
                                controller.getCompanyImageUrl(
                                    controller.userModel!.usersImage!),
                                width: context.scaleConfig.scale(120),
                                height: context.scaleConfig.scale(120),
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                Icons.account_circle,
                                size: context.scaleConfig.scale(120),
                                color: Colors.grey[300],
                              ),
                  ),
                ),
              ),
              SizedBox(height: context.scaleConfig.scale(20)),
              _buildEditableField(
                label: '215'.tr, // Name
                controller: controller.nameController,
                onEditPressed: () {},
                scaleConfig: context.scaleConfig,
              ),
              SizedBox(height: context.scaleConfig.scale(12)),
              _buildEditableField(
                label: '217'.tr, // Phone
                controller: controller.phoneController,
                onEditPressed: () {},
                scaleConfig: context.scaleConfig,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required VoidCallback onEditPressed,
    required ScaleConfig scaleConfig,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(scaleConfig.scale(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: scaleConfig.scale(5),
            offset: Offset(0, scaleConfig.scale(2)),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        vertical: scaleConfig.scale(12),
        horizontal: scaleConfig.scale(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: scaleConfig.scaleText(16),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: label == '215'.tr
                    ? '224'.tr
                    : '225'.tr, // Enter Name or Enter Phone
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(
                fontSize: scaleConfig.scaleText(16),
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
