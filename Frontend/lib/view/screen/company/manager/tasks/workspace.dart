import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/tasks/workspacemanager.dart';
import 'package:tasknotate/core/class/handlingdataview.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';
import 'package:tasknotate/view/widget/company/workspace/addsection.dart';
import 'package:tasknotate/view/widget/company/manager/taskattributes.dart';
import 'package:tasknotate/view/widget/company/workspace/progressbar.dart';

class Workspace extends StatelessWidget {
  const Workspace({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WorkspaceController());
    final scaleConfig = ScaleConfig(context);
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Get.find<WorkspaceController>().goToCompanyCreateTask(),
        child: Icon(Icons.add, size: scaleConfig.scale(24)),
      ),
      appBar: AppBar(
        title: Text(
          "256".tr, // Workspace
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontSize: scaleConfig.scaleText(20)),
        ),
      ),
      body: GetBuilder<WorkspaceController>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: Column(
            children: [
              const ProgressBarWidget(),
              controller.taskcompany.length != 0
                  ? Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(scaleConfig.scale(10)),
                        itemCount: controller.taskcompany.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return AdSection(
                              title: '257'.tr, // Sponsored Ad
                              description: '258'
                                  .tr, // Check out this amazing offer! Limited time only.
                              onAdClick: () => print('Ad clicked!'),
                            );
                          }
                          final task = controller.taskcompany[index - 1];
                          return InkWell(
                            onLongPress: () => showTaskDialog(task.title!, () {
                              controller.deleteTask(task.id!);
                              Get.back();
                            }, context, scaleConfig),
                            onTap: () => controller.goToDetailsTask(task),
                            child: TaskCompanyAttributes(task: task),
                          );
                        },
                      ),
                    )
                  : Center(
                      child: Text(
                        "259".tr, // No Tasks created
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.secondary,
                          fontSize: scaleConfig.scaleText(16),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

void showTaskDialog(String taskTitle, VoidCallback onPressed,
    BuildContext context, ScaleConfig scaleConfig) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final theme = Theme.of(context);

      return Dialog(
        backgroundColor: theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(scaleConfig.scale(12))),
        elevation: scaleConfig.scale(8),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: scaleConfig.scale(Get.width * 0.05),
              vertical: scaleConfig.scale(Get.height * 0.03)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                taskTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontSize: scaleConfig.scaleText(20),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: scaleConfig.scale(16)),
              buildStatusButton(context,
                  label: "260".tr, // Delete?
                  color: Colors.red,
                  icon: Icons.delete,
                  onPressed: onPressed,
                  scaleConfig: scaleConfig),
            ],
          ),
        ),
      );
    },
  );
}

Widget buildStatusButton(BuildContext context,
    {required String label,
    required Color color,
    required IconData icon,
    required VoidCallback onPressed,
    required ScaleConfig scaleConfig}) {
  return MaterialButton(
    onPressed: onPressed,
    color: color,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(scaleConfig.scale(8))),
    padding: EdgeInsets.symmetric(
        horizontal: scaleConfig.scale(16), vertical: scaleConfig.scale(8)),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: scaleConfig.scale(20)),
        SizedBox(width: scaleConfig.scale(8)),
        Text(
          label,
          style: TextStyle(
              fontSize: scaleConfig.scaleText(14), color: Colors.white),
        ),
      ],
    ),
  );
}
