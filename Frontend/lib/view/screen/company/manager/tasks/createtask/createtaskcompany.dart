import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/tasks/createtask/createtask_controller.dart';
import 'package:tasknotate/core/class/handlingdataview.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';
import 'package:tasknotate/view/widget/company/manager/createtask/sectiontitle.dart';
import 'package:tasknotate/view/widget/company/manager/createtask/sendnotification.dart';
import 'package:tasknotate/view/widget/company/manager/createtask/sendviagmail.dart';
import 'package:tasknotate/view/widget/company/manager/createtask/taskdatepicker.dart';
import 'package:tasknotate/view/widget/company/manager/createtask/taskdropdown.dart';
import 'package:tasknotate/view/widget/company/manager/createtask/textfield.dart';

class CreateTaskCompany extends StatelessWidget {
  const CreateTaskCompany({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Get.put(CreatetaskController());
    final scaleConfig = ScaleConfig(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "270".tr, // Create Task
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: scaleConfig.scaleText(20),
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
      ),
      body: GetBuilder<CreatetaskController>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: SingleChildScrollView(
            padding: EdgeInsets.all(scaleConfig.scale(16)),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(scaleConfig.scale(16)),
              ),
              elevation: scaleConfig.scale(4),
              child: Padding(
                padding: EdgeInsets.all(scaleConfig.scale(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(
                        title: "271".tr, theme: theme), // Task Information
                    SizedBox(height: scaleConfig.scale(8)),
                    TaskTextField(
                      label: "272".tr, // Task Title
                      hint: "273".tr, // Enter task title
                      onChanged: controller.updateTaskTitle,
                    ),
                    SizedBox(height: scaleConfig.scale(16)),
                    TaskDropdown(
                      label: "274".tr, // Priority
                      items: controller.priorityOptions,
                      value: controller.priority,
                      onChanged: (value) => controller.updatePriority(value!),
                    ),
                    SizedBox(height: scaleConfig.scale(16)),
                    TaskDropdown(
                      label: "275".tr, // Status
                      items: controller.statusOptions,
                      value: controller.status,
                      onChanged: (value) => controller.updateStatus(value!),
                    ),
                    SizedBox(height: scaleConfig.scale(16)),
                    TaskTextField(
                      label: "276".tr, // Description
                      hint: "277".tr, // Add a description
                      maxLines: 3,
                      onChanged: controller.updateDescription,
                    ),
                    SizedBox(height: scaleConfig.scale(16)),
                    TaskDatePicker(),
                    SizedBox(height: scaleConfig.scale(16)),
                    SendViaGmailSwitch(),
                    SizedBox(height: scaleConfig.scale(8)),
                    SendNotificationSwitch(),
                    SizedBox(height: scaleConfig.scale(24)),
                    Padding(
                      padding: EdgeInsets.all(scaleConfig.scale(16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: controller.statusRequest !=
                                    StatusRequest.loading
                                ? controller.insertTask
                                : null,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: scaleConfig.scale(24),
                                vertical: scaleConfig.scale(12),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    scaleConfig.scale(12)),
                              ),
                            ),
                            child: controller.statusRequest ==
                                    StatusRequest.loading
                                ? SizedBox(
                                    width: scaleConfig.scale(24),
                                    height: scaleConfig.scale(24),
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: scaleConfig.scale(2),
                                    ),
                                  )
                                : Text(
                                    "278".tr, // Save
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      fontSize: scaleConfig.scaleText(16),
                                      color: Colors.black,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
