import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/employee/homeemployee/homeemployeepage_controller.dart';
import 'package:tasknotate/view/screen/company/employee/homeemployee/employee_home.dart';
import 'package:tasknotate/view/screen/company/employee/homeemployee/profile/view_profile_employee.dart';
import 'package:tasknotate/view/screen/company/employee/message_manager_and_employee.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';

class EmployeeHomeNavigator extends StatelessWidget {
  const EmployeeHomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeemployeepageController());
    final scaleConfig = ScaleConfig(context);

    List<Widget> screens = [
      const EmployeeHome(),
      const Messagemanagerandemployee(),
      const ProfileEmployeePage(),
    ];

    return Scaffold(
      body: GetBuilder<HomeemployeepageController>(
        builder: (controller) => screens[controller.currentIndex],
      ),
      bottomNavigationBar: GetBuilder<HomeemployeepageController>(
        builder: (controller) => BottomNavigationBar(
          currentIndex: controller.currentIndex,
          onTap: (index) => controller.onTapBottom(index),
          items: controller.itemsOfScreen
              .map((item) => BottomNavigationBarItem(
                    icon: item.icon,
                    label: item.label,
                  ))
              .toList(),
          type: BottomNavigationBarType.fixed,
          iconSize: scaleConfig.scale(24),
          selectedFontSize: scaleConfig.scaleText(14),
          unselectedFontSize: scaleConfig.scaleText(12),
        ),
      ),
    );
  }
}
