import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tasknotate/controller/tasks/taskupdate_controller.dart';
import 'package:tasknotate/core/constant/appthemes.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';
import 'package:tasknotate/core/functions/formatdate.dart';
import 'package:tasknotate/data/model/categorymodel.dart';
import 'package:tasknotate/data/model/usertasksmodel.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/updatetask/custom_drop_down_button_update.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/updatetask/custom_pick_date_and_time.dart';

class Attributesupdatetask extends StatelessWidget {
  const Attributesupdatetask({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaleConfig = ScaleConfig(context);

    return GetBuilder<TaskUpdatecontroller>(
      builder: (controller) {
        if (controller.task == null) {
          return Center(child: Text("125".tr));
        }

        // Determine the current category name based on selectedCategoryId
        String currentCategoryName = "Home";
        if (controller.selectedCategoryId != null) {
          final selectedCategory = controller.categories.firstWhere(
            (category) => category.id == controller.selectedCategoryId,
            orElse: () => CategoryModel(id: null, categoryName: "Home"),
          );
          currentCategoryName = selectedCategory.categoryName;
        }

        return Card(
          elevation: scaleConfig.scale(4),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(scaleConfig.scale(16))),
          child: Container(
            padding: EdgeInsets.all(scaleConfig.scale(16)),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.surface,
                  theme.colorScheme.surface.withOpacity(0.8)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(scaleConfig.scale(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "126".tr,
                  style: AppThemes.getCommonTextTheme().titleLarge!.copyWith(
                        fontSize: scaleConfig.scaleText(20),
                        color: theme.colorScheme.onSurface,
                      ),
                ),
                SizedBox(height: scaleConfig.scale(12)),
                _buildAttributeRow(
                  icon: Icons.flag,
                  title: "127".tr,
                  widget: CustomDropDownButtonUpdate(
                    value: controller.task!.status ?? "Pending",
                    items: controller.statuses,
                    onChanged: (value) {
                      controller.task = UserTasksModel(
                        id: controller.task?.id,
                        title: controller.task?.title,
                        content: controller.task?.content,
                        date: controller.task?.date,
                        estimatetime: controller.task?.estimatetime,
                        starttime: controller.task?.starttime,
                        reminder: controller.task?.reminder,
                        status: value,
                        priority: controller.task?.priority,
                        subtask: controller.task?.subtask,
                        checked: controller.task?.checked,
                        images: controller.task?.images,
                        category: controller.task?.category,
                      );
                      controller.update();
                    },
                  ),
                  color: theme.colorScheme.secondary,
                  scaleConfig: scaleConfig,
                ),
                SizedBox(height: scaleConfig.scale(8)),
                _buildAttributeRow(
                  icon: Icons.list,
                  title: "368".tr, // Category
                  widget: CustomDropDownButtonUpdate(
                    value: currentCategoryName,
                    items: controller.categories
                        .map((category) => category.categoryName)
                        .toList()
                      ..insert(0, "Home"), // Add "Home" as a default option
                    onChanged: (value) {
                      int? newCategoryId;
                      if (value != "Home") {
                        final selectedCategory =
                            controller.categories.firstWhere(
                          (category) => category.categoryName == value,
                          orElse: () =>
                              CategoryModel(id: null, categoryName: "Home"),
                        );
                        newCategoryId = selectedCategory.id;
                      }
                      controller.selectedCategoryId = newCategoryId;
                      controller.task = UserTasksModel(
                        id: controller.task?.id,
                        title: controller.task?.title,
                        content: controller.task?.content,
                        date: controller.task?.date,
                        estimatetime: controller.task?.estimatetime,
                        starttime: controller.task?.starttime,
                        reminder: controller.task?.reminder,
                        status: controller.task?.status,
                        priority: controller.task?.priority,
                        subtask: controller.task?.subtask,
                        checked: controller.task?.checked,
                        images: controller.task?.images,
                        category: newCategoryId.toString(),
                      );
                      controller.update();
                    },
                  ),
                  color: theme.colorScheme.secondary,
                  scaleConfig: scaleConfig,
                ),
                SizedBox(height: scaleConfig.scale(8)),
                _buildAttributeRow(
                  icon: Icons.priority_high,
                  title: "128".tr,
                  widget: Row(
                    children: [
                      Expanded(
                        child: controller.statusprority
                            ? CustomDropDownButtonUpdate(
                                value: controller.task!.priority ?? "Not Set",
                                items: controller.priorities,
                                onChanged: (value) {
                                  controller.task = UserTasksModel(
                                    id: controller.task?.id,
                                    title: controller.task?.title,
                                    content: controller.task?.content,
                                    date: controller.task?.date,
                                    estimatetime: controller.task?.estimatetime,
                                    starttime: controller.task?.starttime,
                                    reminder: controller.task?.reminder,
                                    status: controller.task?.status,
                                    priority: value,
                                    subtask: controller.task?.subtask,
                                    checked: controller.task?.checked,
                                    images: controller.task?.images,
                                    category: controller.task?.category,
                                  );
                                  controller.update();
                                },
                              )
                            : Text(
                                "132".tr,
                                style: TextStyle(
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.7),
                                  fontSize: scaleConfig.scaleText(16),
                                ),
                              ),
                      ),
                      Switch(
                        activeTrackColor: theme.colorScheme.secondary,
                        inactiveTrackColor: Colors.grey.shade400,
                        inactiveThumbColor: theme.colorScheme.primary,
                        value: controller.statusprority,
                        onChanged: (value) =>
                            controller.switchstatusbutton(value, "priority"),
                      ),
                    ],
                  ),
                  color: theme.colorScheme.secondary,
                  scaleConfig: scaleConfig,
                ),
                SizedBox(height: scaleConfig.scale(8)),
                _buildAttributeRow(
                  icon: FontAwesomeIcons.clock,
                  title: "359".tr,
                  widget: Row(
                    children: [
                      Expanded(
                        child: controller.statusstartDate
                            ? CustomPickDateAndTimeUpdate(
                                text: controller.selectedStartDate != null
                                    ? DateFormat("dd MMM, hh:mm a")
                                        .format(controller.selectedStartDate!)
                                    : "360".tr,
                                onTap: () => controller.pickDateTime(
                                    context, "startdate"),
                              )
                            : Text(
                                "132".tr,
                                style: TextStyle(
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.7),
                                  fontSize: scaleConfig.scaleText(16),
                                ),
                              ),
                      ),
                      Switch(
                        activeTrackColor: theme.colorScheme.secondary,
                        inactiveTrackColor: Colors.grey.shade400,
                        inactiveThumbColor: theme.colorScheme.primary,
                        value: controller.statusstartDate,
                        onChanged: (value) =>
                            controller.switchstatusbutton(value, "startdate"),
                      ),
                    ],
                  ),
                  color: theme.colorScheme.secondary,
                  scaleConfig: scaleConfig,
                ),
                _buildAttributeRow(
                  icon: Icons.timelapse,
                  title: "130".tr,
                  widget: Row(
                    children: [
                      Expanded(
                        child: controller.statusdateandtime
                            ? CustomPickDateAndTimeUpdate(
                                text: controller.selectedDate != null
                                    ? DateFormat("dd MMM, hh:mm a")
                                        .format(controller.selectedDate!)
                                    : "131".tr,
                                onTap: () => controller.pickDateTime(
                                    context, "dateandtime"),
                              )
                            : Text(
                                "132".tr,
                                style: TextStyle(
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.7),
                                  fontSize: scaleConfig.scaleText(16),
                                ),
                              ),
                      ),
                      Switch(
                        activeTrackColor: theme.colorScheme.secondary,
                        inactiveTrackColor: Colors.grey.shade400,
                        inactiveThumbColor: theme.colorScheme.primary,
                        value: controller.statusdateandtime,
                        onChanged: (value) =>
                            controller.switchstatusbutton(value, "dateandtime"),
                      ),
                    ],
                  ),
                  color: theme.colorScheme.secondary,
                  scaleConfig: scaleConfig,
                ),
                SizedBox(height: scaleConfig.scale(8)),
                _buildAttributeRow(
                  icon: FontAwesomeIcons.clock,
                  title: "133".tr,
                  widget: Row(
                    children: [
                      Expanded(
                        child: controller.statusreminder
                            ? CustomPickDateAndTimeUpdate(
                                text: controller.selectedAlarm != null
                                    ? DateFormat("dd MMM, hh:mm a")
                                        .format(controller.selectedAlarm!)
                                    : "134".tr,
                                onTap: () =>
                                    controller.pickDateTime(context, "alarm"),
                              )
                            : Text(
                                "132".tr,
                                style: TextStyle(
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.7),
                                  fontSize: scaleConfig.scaleText(16),
                                ),
                              ),
                      ),
                      Switch(
                        activeTrackColor: theme.colorScheme.secondary,
                        inactiveTrackColor: Colors.grey.shade400,
                        inactiveThumbColor: theme.colorScheme.primary,
                        value: controller.statusreminder,
                        onChanged: (value) =>
                            controller.switchstatusbutton(value, "reminder"),
                      ),
                    ],
                  ),
                  color: theme.colorScheme.secondary,
                  scaleConfig: scaleConfig,
                ),
                SizedBox(height: scaleConfig.scale(8)),
                _buildAttributeRow(
                  icon: Icons.calendar_today,
                  title: "135".tr,
                  widget: Text(
                    controller.task!.date != null &&
                            controller.task!.date!.isNotEmpty
                        ? formatDate(controller.task!.date!)
                        : "136".tr,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: scaleConfig.scaleText(16),
                    ),
                  ),
                  color: theme.colorScheme.secondary,
                  scaleConfig: scaleConfig,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAttributeRow({
    required IconData icon,
    required String title,
    required Widget widget,
    required Color color,
    required ScaleConfig scaleConfig,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(scaleConfig.scale(8)),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(scaleConfig.scale(8)),
          ),
          child: Icon(icon, color: color, size: scaleConfig.scale(20)),
        ),
        SizedBox(width: scaleConfig.scale(12)),
        Text(
          "$title: ",
          style: AppThemes.getCommonTextTheme().bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: scaleConfig.scaleText(16),
              ),
        ),
        Expanded(child: widget),
      ],
    );
  }
}
