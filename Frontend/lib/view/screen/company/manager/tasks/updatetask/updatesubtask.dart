import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/tasks/updatetask/subtaskupdate_controller.dart';
import 'package:companymanagment/core/class/handlingdataview.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/constant/utils/scale_confige.dart';

class UpdatesubtaskView extends StatelessWidget {
  const UpdatesubtaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaleConfig = ScaleConfig(context);

    return GetBuilder<SubtaskUpdateController>(
      init: SubtaskUpdateController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "279".tr, // Update Subtasks
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: scaleConfig.scaleText(20),
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            backgroundColor: theme.colorScheme.primary,
            elevation: 0,
          ),
          body: Handlingdataview(
            statusRequest: controller.statusRequest,
            widget: Padding(
              padding: EdgeInsets.all(scaleConfig.scale(16)),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.subtasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: scaleConfig.scale(2),
                          margin: EdgeInsets.symmetric(
                            vertical: scaleConfig.scale(8),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(scaleConfig.scale(12)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(scaleConfig.scale(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: "282".tr, // Subtask Title
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        scaleConfig.scale(8),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: scaleConfig.scale(12),
                                      vertical: scaleConfig.scale(10),
                                    ),
                                    filled: true,
                                    fillColor: theme
                                        .colorScheme.surfaceContainerHighest,
                                  ),
                                  controller:
                                      controller.titleControllers[index],
                                  onChanged: (value) => controller
                                      .updateSubtaskTitle(index, value),
                                  autofocus: false,
                                  style: TextStyle(
                                    fontSize: scaleConfig.scaleText(16),
                                  ),
                                ),
                                SizedBox(height: scaleConfig.scale(8)),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: "276".tr, // Description
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        scaleConfig.scale(8),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: scaleConfig.scale(12),
                                      vertical: scaleConfig.scale(10),
                                    ),
                                    filled: true,
                                    fillColor: theme
                                        .colorScheme.surfaceContainerHighest,
                                  ),
                                  maxLines: 3,
                                  controller:
                                      controller.descriptionControllers[index],
                                  onChanged: (value) => controller
                                      .updateSubtaskDescription(index, value),
                                  autofocus: false,
                                  style: TextStyle(
                                    fontSize: scaleConfig.scaleText(16),
                                  ),
                                ),
                                SizedBox(height: scaleConfig.scale(8)),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: scaleConfig.scale(24),
                                    ),
                                    onPressed: () =>
                                        controller.removeSubtask(index),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: scaleConfig.scale(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: controller.addSubtask,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: scaleConfig.scale(20),
                              vertical: scaleConfig.scale(12),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(scaleConfig.scale(12)),
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
                                  "283".tr, // Add Subtask
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: scaleConfig.scaleText(16),
                                  ),
                                ),
                        ),
                        OutlinedButton(
                          onPressed: controller.goToFile,
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: scaleConfig.scale(20),
                              vertical: scaleConfig.scale(12),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(scaleConfig.scale(12)),
                            ),
                          ),
                          child: controller.statusRequest ==
                                  StatusRequest.loading
                              ? SizedBox(
                                  width: scaleConfig.scale(24),
                                  height: scaleConfig.scale(24),
                                  child: CircularProgressIndicator(
                                    strokeWidth: scaleConfig.scale(2),
                                  ),
                                )
                              : Text(
                                  "287".tr, // Skip
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: scaleConfig.scaleText(16),
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                        ),
                        ElevatedButton(
                          onPressed:
                              controller.statusRequest == StatusRequest.loading
                                  ? null
                                  : controller.submitSubtasks,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: scaleConfig.scale(20),
                              vertical: scaleConfig.scale(12),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(scaleConfig.scale(12)),
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
                                  "314".tr, // Submit
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: scaleConfig.scaleText(16),
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
        );
      },
    );
  }
}
