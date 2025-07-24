import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/projects/archived_projects_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/view/widget/company/manager/home/empty_state_widget.dart';
import 'package:companymanagment/view/widget/company/manager/projects/archived_project_card.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class ArchivedProjectsPage extends StatelessWidget {
  const ArchivedProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ArchivedProjectsController());
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "archived_projects".tr,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: scale.scaleText(22),
          ),
        ),
      ),
      body: GetBuilder<ArchivedProjectsController>(
        builder: (controller) {
          return Handlingdataview(
            statusRequest: controller.statusRequest,
            widget: controller.archivedProjects.isEmpty
                ? EmptyStateWidget(
                    icon: Icons.archive_outlined,
                    message: "no_archived_projects".tr,
                    details: "archived_projects_details".tr,
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(scale.scale(16)),
                    itemCount: controller.archivedProjects.length,
                    itemBuilder: (context, index) {
                      return ArchivedProjectCard(
                          project: controller.archivedProjects[index]);
                    },
                  ),
          );
        },
      ),
    );
  }
}
