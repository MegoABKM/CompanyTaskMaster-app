import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/home_controller.dart';
import 'package:tasknotate/controller/tasks/taskcreate_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/data/model/categorymodel.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/createtask/content_of_task.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/createtask/custom_appbar_create.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/createtask/custom_drop_down_button.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/createtask/pick_date_and_time.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/createtask/status_of_task.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/createtask/custom_switch.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/createtask/subtasks.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/createtask/switch_and_widget.dart';
import 'package:tasknotate/view/widget/taskhome/crudtasks/timeline_section.dart';

class CreateTask extends StatelessWidget {
  CreateTask({super.key});
  final TaskcreateController controller = Get.put(TaskcreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: context.appTheme.colorScheme.onPrimary,
        elevation: context.scaleConfig.scale(4),
        backgroundColor: context.appTheme.colorScheme.secondary,
        onPressed: () => controller.uploadTask(),
        shape: const CircleBorder(),
        child: Icon(FontAwesomeIcons.checkToSlot,
            size: context.scaleConfig.scale(24)),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: context.appTheme.colorScheme.secondary,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Container(
          color: context.appTheme.colorScheme.surface,
          child: ListView(
            children: [
              Container(
                width: Get.width,
                height: context.scaleConfig.scale(300),
                alignment: AlignmentDirectional.centerStart,
                decoration: BoxDecoration(
                  color: context.appTheme.colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(context.scaleConfig.scale(50)),
                    bottomRight: Radius.circular(context.scaleConfig.scale(50)),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomAppBarTaskCreate(),
                    ContentOfTask(
                        contentcontroller: controller.descriptioncontroller!),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.scaleConfig.scale(30),
                  vertical: context.scaleConfig.scale(10),
                ),
                child: GetBuilder<TaskcreateController>(
                  builder: (controller) => Column(
                    children: [
                      const StatusOfTask(),
                      CustomSwitch(
                        "110".tr,
                        "subtasks",
                        controller.statussubtasks,
                        theme: context.appTheme,
                      ),
                      if (controller.statussubtasks) Subtasks(),
                      SwitchAndWidget(
                        "113".tr, // Priority
                        "prority",
                        controller.statusprority,
                        CustomDropDownButton(
                          type: "priority",
                          controller.prority!,
                          controller.priorities,
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.prority = newValue;
                              controller.update();
                            }
                          },
                        ),
                        theme: context.appTheme,
                      ),
                      SwitchAndWidget(
                        "366".tr,
                        "category",
                        controller.statuscategory,
                        GetBuilder<HomeController>(
                          id: 'task-category-view',
                          builder: (homeController) {
                            final categoryNames = homeController.taskCategories
                                .map((c) => c.categoryName)
                                .toList();
                            return CustomDropDownButton(
                              type: "categroy",
                              controller.selectedCategoryId == null
                                  ? null
                                  : homeController.taskCategories
                                      .firstWhere(
                                        (c) =>
                                            c.id ==
                                            controller.selectedCategoryId,
                                        orElse: () => homeController
                                                .taskCategories.isNotEmpty
                                            ? homeController
                                                .taskCategories.first
                                            : CategoryModel(
                                                id: null, categoryName: "None"),
                                      )
                                      .categoryName,
                              ['None', ...categoryNames],
                              onChanged: (String? newValue) {
                                if (newValue == 'None') {
                                  controller.selectedCategoryId = null;
                                } else {
                                  final selectedCategory =
                                      homeController.taskCategories.firstWhere(
                                          (c) => c.categoryName == newValue);
                                  controller.selectedCategoryId =
                                      selectedCategory.id;
                                }
                                controller.update();
                              },
                            );
                          },
                        ),
                        theme: context.appTheme,
                      ),
                      SwitchAndWidget(
                        "359".tr,
                        "startdate",
                        controller.statusstartdate,
                        const PickDateAndTime("startdate"),
                        theme: context.appTheme,
                      ),
                      SwitchAndWidget(
                        "114".tr,
                        "finishdate",
                        controller.statusfinishdate,
                        const PickDateAndTime("finishdate"),
                        theme: context.appTheme,
                      ),
                      SwitchAndWidget(
                        "115".tr,
                        "timer",
                        controller.statustimer,
                        const PickDateAndTime("timer"),
                        theme: context.appTheme,
                      ),
                      CustomSwitch(
                        "367".tr,
                        "timeline",
                        controller.statustimeline,
                        theme: context.appTheme,
                      ),
                      if (controller.statustimeline) ...[
                        TimelineSection(controller: controller),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: context.scaleConfig.scale(70))
            ],
          ),
        ),
      ),
    );
  }
}
