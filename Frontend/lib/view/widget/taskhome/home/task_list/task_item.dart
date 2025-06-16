import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/home_controller.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';
import 'package:tasknotate/data/model/usertasksmodel.dart';
import 'package:tasknotate/view/widget/taskhome/home/task_list/custom_task_card.dart';
import 'package:tasknotate/view/widget/taskhome/home/task_list/flags/flag_icon_builder.dart';
import 'package:tasknotate/view/widget/taskhome/home/task_list/status_indicator.dart';

class TaskItem extends StatelessWidget {
  final UserTasksModel task;
  final int index;
  final ScaleConfig scale;

  const TaskItem({
    required this.task,
    required this.index,
    required this.scale,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final flags = FlagIconBuilder(
      task: task,
      scale: scale,
      context: context,
    ).build();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: scale.scale(8.0),
        vertical: scale.scale(4.0),
      ),
      child: GestureDetector(
        onTap: () {
          controller.goToViewTask(
            task,
            index.toString(),
          );
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CustomTaskCardHome(task, "${index + 1}", scale: scale),
            ...flags,
            StatusIndicator(
              task: task,
              scale: scale,
            ),
          ],
        ),
      ),
    );
  }
}
