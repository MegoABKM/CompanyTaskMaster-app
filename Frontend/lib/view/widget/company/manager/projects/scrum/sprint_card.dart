import 'package:companymanagment/data/model/company/sprint_model.dart';
import 'package:companymanagment/view/screen/company/manager/projects/sprint_workspace_page.dart';
import 'package:flutter/material.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:get/get.dart';
// NEW IMPORT for the employee's sprint view
import 'package:companymanagment/view/screen/company/employee/projects/employee_sprint_view_page.dart';

class SprintCard extends StatelessWidget {
  final SprintModel sprint;
  final List<TaskCompanyModel> tasks;
  final List<TaskCompanyModel> allProjectTasks;
  final bool isManagerView;

  const SprintCard({
    super.key,
    required this.sprint,
    required this.tasks,
    required this.allProjectTasks,
    this.isManagerView = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scale = context.scaleConfig;

    return Card(
      margin: EdgeInsets.only(bottom: scale.scale(20)),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(scale.scale(12)),
      ),
      child: InkWell(
        // THE FIX: Navigation logic is now conditional
        onTap: () {
          if (isManagerView) {
            // Managers go to the full workspace with editing capabilities
            Get.to(
              () => const SprintWorkspacePage(),
              arguments: {
                'sprint': sprint,
                'tasks': allProjectTasks,
              },
            );
          } else {
            // Employees go to a simple, read-only view of the sprint's tasks
            Get.to(
              () => const EmployeeSprintViewPage(),
              arguments: {
                'sprint': sprint,
                'sprint_tasks': tasks, // Pass only the tasks for this sprint
              },
            );
          }
        },
        borderRadius: BorderRadius.circular(scale.scale(12)),
        child: Padding(
          padding: EdgeInsets.all(scale.scale(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      sprint.sprintName ?? 'unnamed_sprint'.tr,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontSize: scale.scaleText(18)),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: scale.scale(16),
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: scale.scale(4)),
              Text(
                "${sprint.startDate} - ${sprint.endDate}",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                  fontSize: scale.scaleText(12),
                ),
              ),
              const Divider(height: 24),
              Row(
                children: [
                  Icon(Icons.task_alt_outlined,
                      size: scale.scale(16), color: Colors.grey),
                  SizedBox(width: scale.scale(8)),
                  Text(
                    "${tasks.length} ${'tasks_in_sprint_prefix'.tr}",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontSize: scale.scaleText(14)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
