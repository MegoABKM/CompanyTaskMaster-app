import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/main.dart';
import 'package:tasknotate/view/widget/settings/role_selection_button.dart';

class ChangeRoleCard extends StatelessWidget {
  const ChangeRoleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RoleSelectionButton(
          label: "108".tr,
          icon: Icons.person,
          color: Colors.blueAccent,
          onPressed: () {
            myServices.sharedPreferences.setString("userrole", "employee");
            myServices.sharedPreferences.setInt("indexhome", 1);
            Get.offAllNamed(AppRoute.home);
          },
        ),
        RoleSelectionButton(
          label: "109".tr,
          icon: Icons.supervisor_account,
          color: Colors.greenAccent,
          onPressed: () {
            myServices.sharedPreferences.setString("userrole", "manager");
            myServices.sharedPreferences.setInt("indexhome", 1);
            Get.offAllNamed(AppRoute.home);
          },
        ),
      ],
    );
  }
}
