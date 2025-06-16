import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/tasks/taskcreate_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class Subtasks extends GetView<TaskcreateController> {
  const Subtasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.scaleConfig.scale(20)),
        border: Border.all(width: context.scaleConfig.scale(3)),
      ),
      padding: EdgeInsets.all(context.scaleConfig.scale(10)),
      child: Column(
        children: [
          Text(
            "111".tr,
            style: context.appTheme.textTheme.titleLarge!.copyWith(
              color: context.appTheme.colorScheme.secondary,
              fontSize: context.scaleConfig.scaleText(20),
            ),
          ),
          MaterialButton(
            shape: BeveledRectangleBorder(
              borderRadius:
                  BorderRadius.circular(context.scaleConfig.scale(30)),
            ),
            color: context.appTheme.colorScheme.primary,
            onPressed: controller.addtosubtasktextfield,
            child: Text(
              "112".tr,
              style: context.appTheme.textTheme.labelLarge!.copyWith(
                color: context.appTheme.colorScheme.onPrimary,
                fontSize: context.scaleConfig.scaleText(16),
              ),
            ),
          ),
          SizedBox(
            height: context.scaleConfig.scale(300),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.subtaskControllers.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.scaleConfig.scale(10)),
                        child: TextField(
                          style: context.appTheme.textTheme.bodyLarge!.copyWith(
                            color: context.appTheme.colorScheme.onSurface,
                            fontSize: context.scaleConfig.scaleText(16),
                          ),
                          controller: controller.subtaskControllers[index],
                          decoration: InputDecoration(
                            hintStyle:
                                context.appTheme.textTheme.bodyLarge!.copyWith(
                              color: context.appTheme.colorScheme.onSurface,
                              fontSize: context.scaleConfig.scaleText(16),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: context.scaleConfig.scale(10)),
                            hintText: "112".tr,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: context.appTheme.colorScheme.primary),
                              borderRadius: BorderRadius.circular(
                                  context.scaleConfig.scale(8)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      context.appTheme.colorScheme.onSurface),
                              borderRadius: BorderRadius.circular(
                                  context.scaleConfig.scale(8)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () => controller.removeSubtask(index),
                        icon: Icon(FontAwesomeIcons.minus,
                            color: context.appTheme.colorScheme.error,
                            size: context.scaleConfig.scale(20)),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
