import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/homemanager/homemanagerpage_controller.dart';
import 'package:tasknotate/view/screen/company/manager/homemanager/manager_home.dart';
import 'package:tasknotate/view/screen/company/manager/homemanager/notification_manager.dart';
import 'package:tasknotate/view/screen/company/manager/homemanager/profile/viewprofilemanager.dart';
import 'package:tasknotate/view/screen/company/manager/homemanager/request_join.dart';
import 'package:tasknotate/view/screen/company/employee/message_manager_and_employee.dart';

class ManagerHomeNavigator extends StatelessWidget {
  const ManagerHomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomemanagerpageController());

    // Define the main screens
    List<Widget> screens = [
      const Managerpage(), // Companies
      const Messagemanagerandemployee(), // Messages
      const RequestJoinPage(), // Request
      const ProfileManagerPage(),
      const NotificationManager(),
      // Profile
    ];

    return Scaffold(
      body: GetBuilder<HomemanagerpageController>(
        builder: (controller) {
          return screens[controller.currentIndex]; // Show selected screen
        },
      ),
      bottomNavigationBar: GetBuilder<HomemanagerpageController>(
        builder: (controller) {
          return BottomNavigationBar(
            currentIndex: controller.currentIndex,
            onTap: (index) => controller.onTapBottom(index), // Update index
            items: controller.itemsOfScreen,
            type:
                BottomNavigationBarType.fixed, // Ensure all buttons are visible
          );
        },
      ),
    );
  }
}
