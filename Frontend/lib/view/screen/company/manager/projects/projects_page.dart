import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/view/screen/company/manager/projects/archived_projects_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/projects/projects_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/widget/company/manager/home/empty_state_widget.dart';
import 'package:companymanagment/view/widget/company/manager/projects/project_card.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProjectsController());
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "projects".tr,
          style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold, fontSize: scale.scaleText(22)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.archive_outlined),
            tooltip: "view_archived_projects".tr,
            onPressed: () => Get.to(() => const ArchivedProjectsPage()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.find<ProjectsController>().goToCreateProject(),
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<ProjectsController>(
        builder: (controller) {
          if (controller.companyId == null &&
              controller.statusRequest != StatusRequest.loading) {
            return EmptyStateWidget(
              icon: Icons.error_outline,
              message: "no_company_found".tr,
              details: "create_company_first_for_projects".tr,
            );
          }

          return Handlingdataview(
            statusRequest: controller.statusRequest,
            widget: controller.projects.isEmpty
                ? EmptyStateWidget(
                    icon: Icons.folder_off_outlined,
                    message: "no_active_projects".tr,
                    details: "create_first_project_details".tr,
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(scale.scale(16)),
                    itemCount: controller.projects.length,
                    itemBuilder: (context, index) {
                      if (controller.projects[index].status != 'Archived') {
                        return ProjectCard(project: controller.projects[index]);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
          );
        },
      ),
    );
  }
}
