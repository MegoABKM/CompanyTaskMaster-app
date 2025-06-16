import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/homemanager/profile.dart/viewprofilemanagerpage_controller.dart';
import 'package:tasknotate/core/class/handlingdataview.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';

class ProfileManagerPage extends StatelessWidget {
  const ProfileManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ViewProfileManagerController());
    final scaleConfig = ScaleConfig(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '214'.tr, // Profile
          style: TextStyle(fontSize: scaleConfig.scaleText(20)),
        ),
      ),
      body: GetBuilder<ViewProfileManagerController>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: Padding(
            padding: EdgeInsets.all(scaleConfig.scale(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: ClipOval(
                    child: controller.userModel?.usersImage != null &&
                            controller.userModel?.usersImage != ''
                        ? Image.network(
                            controller.getCompanyImageUrl(
                                controller.userModel!.usersImage!),
                            width: scaleConfig.scale(120),
                            height: scaleConfig.scale(120),
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.account_circle,
                            size: scaleConfig.scale(120),
                            color: Colors.grey[300],
                          ),
                  ),
                ),
                SizedBox(height: scaleConfig.scale(20)),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildProfileSection(
                          '215'.tr, // Name
                          controller.userModel?.usersName ?? "N/A",
                          scaleConfig,
                        ),
                        SizedBox(height: scaleConfig.scale(12)),
                        _buildProfileSection(
                          '216'.tr, // Email
                          controller.userModel?.usersEmail ?? "N/A",
                          scaleConfig,
                        ),
                        SizedBox(height: scaleConfig.scale(12)),
                        _buildProfileSection(
                          '217'.tr, // Phone
                          controller.userModel?.usersPhone?.toString() ?? "N/A",
                          scaleConfig,
                        ),
                        SizedBox(height: scaleConfig.scale(12)),
                        _buildProfileSection(
                          '218'.tr, // Role
                          _getRoleName(controller.userModel?.usersRole),
                          scaleConfig,
                        ),
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () => controller.goToUpdateProfile(),
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text(
                    '219'.tr, // Edit Profile
                    style: TextStyle(fontSize: scaleConfig.scaleText(16)),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: scaleConfig.scale(16)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(scaleConfig.scale(8)),
                  ),
                ),
                SizedBox(height: scaleConfig.scale(16)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(
      String label, String value, ScaleConfig scaleConfig) {
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
          Text(
            value,
            style: TextStyle(
              fontSize: scaleConfig.scaleText(16),
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  String _getRoleName(int? role) {
    switch (role) {
      case 0:
        return '220'.tr; // Manager
      case 1:
        return '221'.tr; // Employee
      case 2:
        return '222'.tr; // Manager and Employee
      default:
        return '223'.tr; // None
    }
  }
}
