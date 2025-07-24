import 'package:companymanagment/controller/company/manager/homemanager/home_manager_controller.dart';
import 'package:companymanagment/view/screen/settings_page.dart';
import 'package:companymanagment/view/widget/company/manager/home/active_projects_section.dart';
import 'package:companymanagment/view/widget/company/manager/home/company_header_card.dart';
import 'package:companymanagment/view/widget/company/manager/home/dashboard_action_card.dart';
import 'package:companymanagment/view/widget/company/manager/home/dashboard_stat_card.dart';
import 'package:companymanagment/view/widget/company/manager/home/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/core/constant/routes.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/screen/company/manager/homemanager/notification_manager.dart';
import 'package:companymanagment/view/screen/company/manager/homemanager/request_join.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';
import 'package:companymanagment/view/widget/company/manager/home/task_check_section_manager.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Managerpage extends StatelessWidget {
  const Managerpage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ManagerhomeController());
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "79".tr, // Manager Dashboard
          style: theme.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => const RequestJoinPage()),
            icon: const Icon(Icons.group_add_outlined),
            tooltip: 'Join Requests',
          ),
          IconButton(
            onPressed: () => Get.to(() => const NotificationManager()),
            icon: const Icon(Icons.notifications_outlined),
            tooltip: 'Task Notifications',
          ),
          SizedBox(width: scale.scale(8)),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'settings'.tr,
            onPressed: () {
              // Navigate to the reusable settings page
              Get.to(() => const SettingsPage());
            },
          ),
          SizedBox(width: scale.scale(8)),
        ],
      ),
      body: GetBuilder<ManagerhomeController>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: _buildContent(context, controller),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ManagerhomeController controller) {
    final bool hasCompany = controller.companyData.isNotEmpty;
    final scale = context.scaleConfig;

    if (hasCompany) {
      // If company exists, show the Command Center Dashboard
      final company = controller.companyData.first;
      return ListView(
        padding: EdgeInsets.all(scale.scale(16)),
        children: [
          CompanyHeaderCard(company: company),
          SizedBox(height: scale.scale(20)),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: scale.scale(16),
            mainAxisSpacing: scale.scale(16),
            childAspectRatio: 1.1,
            children: [
              DashboardStatCard(
                icon: Icons.groups_2_outlined,
                value: company.employees?.length.toString() ?? '0',
                label: "205".tr, // "Employees"
              ),
              DashboardStatCard(
                icon: Icons.checklist_rtl_outlined,
                value: controller.activeProjects.length.toString(),
                label: "380".tr, // "Active Projects"
              ),
            ],
          ),
          SizedBox(height: scale.scale(20)),
          DashboardActionCard(
            icon: Icons.space_dashboard_outlined,
            label: "go_to_projects".tr, // "Go to Workspace"
            onTap: () => Get.toNamed(AppRoute.workspace, arguments: {
              "companyid": company.companyId,
              "companyemployee": company.employees,
            }),
          ),
          SizedBox(height: scale.scale(12)),
          DashboardActionCard(
            icon: Icons.settings_outlined,
            label: "82".tr, // "View Company Details"
            onTap: () => controller.goToDetailsCompany(company),
          ),
          SizedBox(height: scale.scale(20)),
          if (controller.activeProjects.isNotEmpty) ...[
            const ActiveProjectsSection(),
            SizedBox(height: scale.scale(20)),
          ],
          const TaskCheckSection(),
        ].animate(interval: 80.ms).fade(duration: 400.ms).slideY(begin: 0.2),
      );
    } else {
      // If no company, show the "Create Company" call to action with updated text
      return Center(
        child: Padding(
          padding: EdgeInsets.all(scale.scale(16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EmptyStateWidget(
                icon: Icons.add_business_outlined,
                message: "create_your_company_on_injaz".tr, // NEW KEY
                details: "no_current_company".tr, // NEW KEY
              ),
              SizedBox(height: scale.scale(32)),
              CustomButtonAuth(
                textbutton: "84".tr, // Create New Company
                onPressed: () => Get.toNamed(AppRoute.companycreate),
              ),
              SizedBox(height: scale.scale(16)),
              Text(
                "one_company_rule".tr, // NEW KEY
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall?.copyWith(
                    color:
                        context.theme.colorScheme.onSurface.withOpacity(0.5)),
              )
            ],
          ),
        ),
      );
    }
  }
}
