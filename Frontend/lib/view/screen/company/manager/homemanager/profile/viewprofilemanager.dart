import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/homemanager/profile.dart/viewprofilemanagerpage_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';
import 'package:companymanagment/view/widget/profile/profile_info_tile.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileManagerPage extends StatelessWidget {
  const ProfileManagerPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    Get.put(ViewProfileManagerController());
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: GetBuilder<ViewProfileManagerController>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: controller.userModel == null
              ? Center(child: Text("profile_not_found".tr))
              : Column(
                  children: [
                    _buildProfileHeader(context, controller),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(scale.scale(16)),
                        children: [
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(scale.scale(16)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(scale.scale(16)),
                              child: Column(
                                children: [
                                  ProfileInfoTile(
                                    icon: Icons.email_outlined,
                                    label: '216'.tr,
                                    value: controller.userModel!.usersEmail ??
                                        "N/A",
                                  ),
                                  const Divider(height: 24),
                                  ProfileInfoTile(
                                    icon: Icons.phone_outlined,
                                    label: '217'.tr,
                                    value: controller.userModel!.usersPhone
                                            ?.toString() ??
                                        "N/A",
                                  ),
                                  // const Divider(height: 24),
                                  // ProfileInfoTile(
                                  //   icon: Icons.work_outline,
                                  //   label: '218'.tr,
                                  //   value: _getRoleName(
                                  //       controller.userModel!.usersRole),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: scale.scale(24)),
                          CustomButtonAuth(
                            textbutton: 'edit_profile'.tr,
                            onPressed: controller.goToUpdateProfile,
                          ),
                          SizedBox(height: scale.scale(16)),
                          // NEW: Sign Out Button
                          OutlinedButton.icon(
                            icon: const Icon(Icons.logout),
                            label: Text('sign_out'.tr),
                            onPressed: controller.signOut,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: theme.colorScheme.error,
                              side: BorderSide(
                                  color:
                                      theme.colorScheme.error.withOpacity(0.5)),
                              minimumSize: const Size(double.infinity, 50),
                            ),
                          ),
                        ]
                            .animate(interval: 80.ms)
                            .fade(duration: 400.ms)
                            .slideY(begin: 0.2),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(
      BuildContext context, ViewProfileManagerController controller) {
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Container(
      padding: EdgeInsets.only(
          top: scale.scale(50),
          bottom: scale.scale(24),
          left: scale.scale(24),
          right: scale.scale(24)),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
              color: theme.shadowColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: scale.scale(50),
            backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
            backgroundImage: (controller.userModel?.usersImage != null &&
                    controller.userModel!.usersImage!.isNotEmpty)
                ? NetworkImage(controller
                    .getCompanyImageUrl(controller.userModel!.usersImage!))
                : null,
            child: (controller.userModel?.usersImage == null ||
                    controller.userModel!.usersImage!.isEmpty)
                ? Icon(
                    Icons.person,
                    size: scale.scale(60),
                    color: theme.colorScheme.primary,
                  )
                : null,
          ),
          SizedBox(height: scale.scale(16)),
          Text(
            controller.userModel!.usersName ?? "N/A",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
