import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/tasks/createtask/createsubtask_controller.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';

class CreateSubtasksPage extends StatelessWidget {
  const CreateSubtasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SubtaskController controller = Get.put(SubtaskController());
    final scaleConfig = ScaleConfig(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "279".tr, // Create Subtasks
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: scaleConfig.scaleText(20),
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
      ),
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: controller.subtasks.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.task_alt,
                            size: scaleConfig.scale(80),
                            color: theme.colorScheme.primary.withOpacity(0.7),
                          ),
                          SizedBox(height: scaleConfig.scale(16)),
                          Text(
                            "280".tr, // No subtasks added yet.
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontSize: scaleConfig.scaleText(18),
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: scaleConfig.scale(20)),
                          ElevatedButton(
                            onPressed: controller.skipToAddFile,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: scaleConfig.scale(20),
                                vertical: scaleConfig.scale(12),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    scaleConfig.scale(12)),
                              ),
                            ),
                            child: Text(
                              "281".tr, // Skip to File Upload
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontSize: scaleConfig.scaleText(16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.subtasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(scaleConfig.scale(8)),
                          elevation: scaleConfig.scale(2),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(scaleConfig.scale(12)),
                          ),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.all(scaleConfig.scale(12)),
                            title: TextField(
                              controller:
                                  controller.subtasks[index].titleController,
                              decoration: InputDecoration(
                                labelText: "282".tr, // Subtask Title
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      scaleConfig.scale(8)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: scaleConfig.scale(12),
                                  vertical: scaleConfig.scale(10),
                                ),
                              ),
                              style: TextStyle(
                                fontSize: scaleConfig.scaleText(16),
                              ),
                            ),
                            subtitle: Padding(
                              padding:
                                  EdgeInsets.only(top: scaleConfig.scale(8)),
                              child: TextField(
                                controller: controller
                                    .subtasks[index].descriptionController,
                                decoration: InputDecoration(
                                  labelText: "276".tr, // Description
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        scaleConfig.scale(8)),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: scaleConfig.scale(12),
                                    vertical: scaleConfig.scale(10),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: scaleConfig.scaleText(16),
                                ),
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete,
                                  color: Colors.red,
                                  size: scaleConfig.scale(24)),
                              onPressed: () => controller.removeSubtask(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: EdgeInsets.all(scaleConfig.scale(16)),
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
                    child: Text(
                      "283".tr, // Add Subtask
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: scaleConfig.scaleText(16),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      controller.statusRequest != StatusRequest.loading
                          ? ElevatedButton(
                              onPressed: controller.submitSubtasks,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: scaleConfig.scale(20),
                                  vertical: scaleConfig.scale(12),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      scaleConfig.scale(12)),
                                ),
                              ),
                              child: Text(
                                "278".tr, // Save
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontSize: scaleConfig.scaleText(16),
                                ),
                              ),
                            )
                          : SizedBox(
                              width: scaleConfig.scale(24),
                              height: scaleConfig.scale(24),
                              child: CircularProgressIndicator(
                                strokeWidth: scaleConfig.scale(2),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
