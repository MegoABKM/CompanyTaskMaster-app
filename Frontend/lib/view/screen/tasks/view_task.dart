// lib/view/screen/tasks/view_task.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/tasks/taskviewcontroller.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/viewtask/custom_float_action_button.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/viewtask/image_section.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/viewtask/task_view_attributes.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/viewtask/task_view_content.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/viewtask/task_view_subtask.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/viewtask/task_view_timeline.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/viewtask/task_view_title.dart';

class ViewTask extends StatelessWidget {
  const ViewTask({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Taskviewcontroller());

    return Scaffold(
      backgroundColor: context.appTheme.colorScheme.surface,
      body: GetBuilder<Taskviewcontroller>(
        builder: (controller) {
          if (controller.task == null) {
            return Center(child: Text("125".tr));
          }
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: context.scaleConfig.scale(200),
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          context.appTheme.colorScheme.primary,
                          context.appTheme.colorScheme.secondary
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.all(context.scaleConfig.scale(16)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TaskViewTitle(
                              indextask: controller.index ?? "0",
                              titleText: controller.task!.title ?? "No Title",
                            ),
                            if (controller.task!.status != "Completed")
                              Padding(
                                padding: EdgeInsets.only(
                                    top: context.scaleConfig.scale(16)),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    controller.updateStatus(
                                      controller.task!.status ?? "",
                                      controller.task!.id ?? "",
                                      "Completed",
                                    );
                                    Get.offAllNamed(AppRoute.home);
                                  },
                                  icon: Icon(Icons.check,
                                      size: context.scaleConfig.scale(18)),
                                  label: Text("156".tr), // "Mark as Done"
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: context
                                        .appTheme.colorScheme.onSecondary,
                                    backgroundColor: context
                                        .appTheme.colorScheme.onSurface
                                        .withOpacity(0.5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          context.scaleConfig.scale(30)),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: context.scaleConfig.scale(16),
                                      vertical: context.scaleConfig.scale(8),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: context.appTheme.colorScheme.onPrimary,
                      size: context.scaleConfig.scale(24)),
                  onPressed: () => Get.back(),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(context.scaleConfig.scale(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TaskViewAttributes(
                        task: controller.task!,
                        onTap: () => controller.pickDateTime(context),
                      ),
                      if (controller.task!.content?.isNotEmpty ?? false)
                        Padding(
                          padding: EdgeInsets.only(
                              top: context.scaleConfig.scale(16)),
                          child: TaskViewContent(
                              content: controller.task!.content!),
                        ),
                      if (controller.decodedImages.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(
                              top: context.scaleConfig.scale(16)),
                          child: ImageSectionTask(
                            controller: controller,
                          ),
                        ),
                      if (controller.task!.subtask != "Not Set")
                        Padding(
                          padding: EdgeInsets.only(
                              top: context.scaleConfig.scale(16)),
                          child: const TaskViewSubtask(),
                        ),
                      if (controller.decodedTimeline.isNotEmpty)
                        Padding(
                            padding: EdgeInsets.only(
                                top: context.scaleConfig.scale(16)),
                            child: TaskViewTimeline(
                              controller: controller,
                            )),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: CustomFloatActionButtonView(
        onPressed: () => Get.find<Taskviewcontroller>().goToUpdateTask(),
      ),
    );
  }
}
