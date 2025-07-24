import 'package:companymanagment/view/screen/company/manager/finance/company_finance_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/homemanager/home_manager_navigator_controller.dart';
import 'package:companymanagment/view/screen/company/manager/homemanager/manager_home.dart';
import 'package:companymanagment/view/screen/company/manager/homemanager/profile/viewprofilemanager.dart';
import 'package:companymanagment/view/screen/company/manager/projects/projects_page.dart'; // IMPORT NEW PAGE

class ManagerHomeNavigator extends StatelessWidget {
  const ManagerHomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Get.put(HomemanagerpageController());

    // Define the simplified list of main screens
    List<Widget> screens = [
      const Managerpage(), // Companies
      const ProjectsPage(), // ADDED NEW SCREEN
      const CompanyFinancePage(), // NEW SCREEN
      const ProfileManagerPage(), // Profile
    ];

    return Scaffold(
      body: GetBuilder<HomemanagerpageController>(
        builder: (controller) {
          return screens[controller.currentIndex];
        },
      ),
      bottomNavigationBar: GetBuilder<HomemanagerpageController>(
        builder: (controller) {
          return BottomNavigationBar(
            currentIndex: controller.currentIndex,
            onTap: (index) => controller.onTapBottom(index),
            items: controller.itemsOfScreen,
            type: BottomNavigationBarType.fixed,
            backgroundColor: theme.colorScheme.surface,
            selectedItemColor: theme.colorScheme.primary,
            unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.6),
            elevation: 8.0,
          );
        },
      ),
    );
  }
}
