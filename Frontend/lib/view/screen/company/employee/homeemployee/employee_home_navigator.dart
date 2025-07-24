import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/employee/homeemployee/homeemployeepage_controller.dart';
import 'package:companymanagment/view/screen/company/employee/homeemployee/employee_home.dart';
import 'package:companymanagment/view/screen/company/employee/homeemployee/profile/view_profile_employee.dart';
import 'package:companymanagment/view/screen/company/employee/message_manager_and_employee.dart';

class EmployeeHomeNavigator extends StatelessWidget {
  const EmployeeHomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeemployeepageController());
    final theme = Theme.of(context);

    // List of screens for the navigator
    final List<Widget> screens = [
      const EmployeeHome(),
      const Messagemanagerandemployee(),
      const ProfileEmployeePage(),
    ];

    // Define BottomNavigationBar items here to use translations
    final List<BottomNavigationBarItem> itemsOfScreen = [
      BottomNavigationBarItem(
        icon: const Icon(Icons.business_outlined),
        activeIcon: const Icon(Icons.business_rounded),
        label: "companies_nav".tr,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.message_outlined),
        activeIcon: const Icon(Icons.message_rounded),
        label: "messages_nav".tr,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.person_outline),
        activeIcon: const Icon(Icons.person),
        label: "profile_nav".tr,
      ),
    ];

    return Scaffold(
      body: GetBuilder<HomeemployeepageController>(
        builder: (controller) => screens[controller.currentIndex],
      ),
      bottomNavigationBar: GetBuilder<HomeemployeepageController>(
        builder: (controller) => BottomNavigationBar(
          currentIndex: controller.currentIndex,
          onTap: (index) => controller.onTapBottom(index),
          items: itemsOfScreen,
          type: BottomNavigationBarType.fixed,
          backgroundColor: theme.colorScheme.surface,
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.6),
          elevation: 8.0,
        ),
      ),
    );
  }
}
