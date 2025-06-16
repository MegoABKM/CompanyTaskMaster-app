import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/settings_controller.dart';
import 'package:tasknotate/view/widget/settings/role_selection_button.dart';

class SignOutButton extends GetView<SettingsController> {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RoleSelectionButton(
        label: "107".tr,
        icon: Icons.logout,
        color: Colors.redAccent,
        onPressed: () {
          controller.signOut();
        },
      ),
    );
  }
}
