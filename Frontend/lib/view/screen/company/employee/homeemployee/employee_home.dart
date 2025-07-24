import 'package:companymanagment/view/screen/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/employee/homeemployee/employee_home_navigator_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/widget/company/employee/home/company_section.dart';
import 'package:companymanagment/view/widget/company/employee/home/join_company_section.dart';
import 'package:companymanagment/view/widget/company/employee/home/recent_tasks.dart';
// NEW IMPORTS
import 'package:companymanagment/view/widget/company/employee/home/employee_project_card.dart';
import 'package:companymanagment/view/widget/company/manager/home/empty_state_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EmployeeHome extends StatelessWidget {
  const EmployeeHome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EmployeehomeController());
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text('employee_dashboard'.tr),
        centerTitle: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'settings'.tr,
            onPressed: () {
              // Navigate to the new settings page
              Get.to(() => const SettingsPage());
            },
          ),
        ],
      ),
      body: GetBuilder<EmployeehomeController>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: RefreshIndicator(
            onRefresh: () => controller.getData(), // Allows pull-to-refresh
            child: ListView(
              padding: EdgeInsets.all(scale.scale(16)),
              children: [
                // NEW: Projects Section
                _buildSectionTitle(context, 'your_projects'.tr),
                SizedBox(height: scale.scale(10)),
                controller.projectList.isNotEmpty
                    ? _buildProjectsSection(controller)
                    : EmptyStateWidget(
                        icon: Icons.folder_off_outlined,
                        message: 'no_projects_assigned'.tr,
                      ),
                SizedBox(height: scale.scale(24)),

                // Existing Sections
                _buildSectionTitle(context, 'recent_tasks'.tr),
                SizedBox(height: scale.scale(10)),
                controller.newTaskList.isNotEmpty
                    ? const RecentTasks()
                    : EmptyStateWidget(
                        icon: Icons.task_alt_outlined,
                        message: 'no_new_tasks'.tr,
                      ),
                SizedBox(height: scale.scale(24)),
                _buildSectionTitle(context, 'your_companies'.tr),
                SizedBox(height: scale.scale(10)),
                controller.companyList.isNotEmpty
                    ? const CompanySection()
                    : EmptyStateWidget(
                        icon: Icons.business_center_outlined,
                        message: 'no_companies_joined'.tr,
                      ),
                SizedBox(height: scale.scale(24)),
                const JoinCompanySection(),
              ]
                  .animate(interval: 80.ms)
                  .fade(duration: 400.ms)
                  .slideY(begin: 0.2),
            ),
          ),
        ),
      ),
    );
  }

  // NEW: Widget builder for the projects list
  Widget _buildProjectsSection(EmployeehomeController controller) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.projectList.length,
      itemBuilder: (context, index) {
        final project = controller.projectList[index];
        return EmployeeProjectCard(
          project: project,
          onTap: () => controller.goToProjectWorkspace(project),
        );
      },
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: context.appTheme.textTheme.headlineSmall
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
