import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/employee/homeemployee/profile/viewprofileemployee_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';
import 'package:companymanagment/view/widget/profile/profile_info_tile.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileEmployeePage extends StatelessWidget {
  const ProfileEmployeePage({super.key});

  String _getRoleName(int? role) {
    switch (role) {
      case 0:
        return 'role_manager'.tr;
      case 1:
        return 'role_employee'.tr;
      default:
        return 'not_specified'.tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ViewProfileEmployeeController());
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: GetBuilder<ViewProfileEmployeeController>(
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
                                    label: 'email'.tr,
                                    value: controller.userModel!.usersEmail ??
                                        "not_available".tr,
                                  ),
                                  const Divider(height: 24),
                                  ProfileInfoTile(
                                    icon: Icons.phone_outlined,
                                    label: 'phone'.tr,
                                    value: controller.userModel!.usersPhone
                                            ?.toString() ??
                                        "not_available".tr,
                                  ),
                                  const Divider(height: 24),
                                  ProfileInfoTile(
                                    icon: Icons.work_outline,
                                    label: 'role_employee'.tr,
                                    value: _getRoleName(
                                        controller.userModel!.usersRole),
                                  ),
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
                          // Sign Out Button
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
      BuildContext context, ViewProfileEmployeeController controller) {
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
          Text(
            'employee_profile'.tr,
            style: theme.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: scale.scale(16)),
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
            style: theme.textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
