import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/home_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/core/functions/alertexitapp.dart';
import 'package:tasknotate/main.dart';
import 'package:tasknotate/view/screen/auth/login.dart';
import 'package:tasknotate/view/screen/company/employee/homeemployee/employee_home_navigator.dart';
import 'package:tasknotate/view/screen/company/manager/homemanager/manager_home_navigator.dart';
import 'package:tasknotate/view/screen/company/company_home.dart';
import 'package:tasknotate/view/screen/notes_home.dart';
import 'package:tasknotate/view/screen/settings.dart';
import 'package:tasknotate/view/screen/tasks_home.dart';
import 'package:tasknotate/view/widget/home/all_nav_buttons.dart';
import 'package:tasknotate/view/widget/home/sloped_sidebar_painter.dart';

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    String? userrole = myServices.sharedPreferences.getString("userrole");
    List<Widget> screens = [
      const Taskshome(),
      controller.userid == null
          ? const Login()
          : userrole == "manager"
              ? const ManagerHomeNavigator()
              : userrole == "employee"
                  ? const EmployeeHomeNavigator()
                  : const CompanyHome(),
      const NotesHome(),
      const Settings()
    ];
    double sidebarWidth = Get.width * 0.1;
    double minWidth = context.scaleConfig.scale(60);
    double maxWidth = context.scaleConfig.scale(120);
    if (sidebarWidth < minWidth) sidebarWidth = minWidth;
    if (sidebarWidth > maxWidth) sidebarWidth = maxWidth;
    double sidebarHeight = context.scaleConfig.scale(200);
    bool isArabic = myServices.sharedPreferences.getString("lang") == "ar";
    return Scaffold(
      // ignore: deprecated_member_use
      body: WillPopScope(
        onWillPop: () => alertExitApp(),
        child: Stack(
          children: [
            GetBuilder<HomeController>(
              builder: (controller) => screens[controller.currentIndex],
            ),
            Positioned(
              top: context.scaleConfig.scale(40),
              left: isArabic ? 0 : null,
              right: isArabic ? null : 0,
              child: SizedBox(
                width: sidebarWidth,
                height: sidebarHeight,
                child: CustomPaint(
                    painter: SlopedSidebarPainter(context, isArabic: isArabic),
                    child: AllNavButtons(
                      controller: controller,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
