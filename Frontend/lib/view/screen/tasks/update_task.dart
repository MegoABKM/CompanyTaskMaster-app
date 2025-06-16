import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/tasks/taskupdate_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/updatetask/appbar_task_update.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/updatetask/attributesupdatetask.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/updatetask/discription_update_task.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/updatetask/float_action_button_update_task.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/updatetask/image_grid_view_task_update.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/updatetask/no_image_task_update.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/updatetask/subtask_update.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/updatetask/timeline_task_update.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/updatetask/title_update_task.dart';

class UpdateTask extends StatelessWidget {
  const UpdateTask({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskUpdatecontroller controller = Get.put(TaskUpdatecontroller());
    return Scaffold(
      backgroundColor: context.appTheme.scaffoldBackgroundColor,
      body: GetBuilder<TaskUpdatecontroller>(
        builder: (controller) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: context.scaleConfig.scale(200),
                flexibleSpace: const FlexibleSpaceBar(
                  background: AppbarTaskUpdate(),
                ),
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(context.scaleConfig.scale(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TitleUpdateTask(),
                      SizedBox(height: context.scaleConfig.scale(16)),
                      const Attributesupdatetask(),
                      SizedBox(height: context.scaleConfig.scale(16)),
                      const Discriptionupdatetask(),
                      SizedBox(height: context.scaleConfig.scale(16)),
                      controller.decodedImages.isNotEmpty
                          ? const Imagegridviewtaskupdate()
                          : const Noimagetaskupdate(),
                      SizedBox(height: context.scaleConfig.scale(16)),
                      const Subtaskupdate.SubtaskUpdate(),
                      SizedBox(height: context.scaleConfig.scale(16)),
                      TimelineTaskUpdate(
                        controller: controller,
                      ),
                      SizedBox(height: context.scaleConfig.scale(80)),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloataActionButtonUpdateTask(
        onPressed: controller.updatetaskafteredit,
      ),
    );
  }
}
