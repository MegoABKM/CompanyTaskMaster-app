import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/tasks/taskcreate_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class ContentOfTask extends GetView<TaskcreateController> {
  final TextEditingController contentcontroller;

  const ContentOfTask({required this.contentcontroller, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.scaleConfig.scale(30),
          vertical: context.scaleConfig.scale(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              style: context.appTheme.textTheme.bodyLarge!.copyWith(
                fontSize: context.scaleConfig.scaleText(20),
                color: context.appTheme.colorScheme.onSurface,
              ),
              controller: contentcontroller,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintStyle: context.appTheme.textTheme.bodyLarge!.copyWith(
                  fontSize: context.scaleConfig.scaleText(24),
                  color:
                      context.appTheme.colorScheme.onSurface.withOpacity(0.6),
                ),
                hintText: "118".tr,
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: context.scaleConfig.scale(12)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: GetBuilder<TaskcreateController>(
                    builder: (controller) => controller.images.isNotEmpty
                        ? SizedBox(
                            height: context.scaleConfig.scale(60),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.images.length,
                              itemBuilder: (context, index) {
                                final imagePath =
                                    controller.images[index] ?? '';
                                return GestureDetector(
                                  onTap: () {
                                    if (imagePath.isNotEmpty) {
                                      Get.dialog(
                                        Dialog(
                                          child: Container(
                                            padding: EdgeInsets.all(
                                                context.scaleConfig.scale(16)),
                                            child: Image.file(
                                              File(imagePath),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        barrierDismissible: true,
                                      );
                                    }
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            context.scaleConfig.scale(8)),
                                        child: imagePath.isNotEmpty
                                            ? Image.file(
                                                height: context.scaleConfig
                                                    .scale(60),
                                                width: context.scaleConfig
                                                    .scale(60),
                                                File(imagePath),
                                                fit: BoxFit.fill,
                                              )
                                            : Text("119".tr),
                                      ),
                                      Positioned(
                                        bottom: context.scaleConfig.scale(30),
                                        left: context.scaleConfig.scale(30),
                                        child: IconButton(
                                          color: context
                                              .appTheme.colorScheme.error,
                                          onPressed: () =>
                                              controller.deleteImage(imagePath),
                                          icon: Icon(
                                            Icons.remove,
                                            size: context.scaleConfig.scale(20),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : Text(
                            "120".tr,
                            style:
                                context.appTheme.textTheme.bodyMedium!.copyWith(
                              color: context.appTheme.colorScheme.onSurface
                                  .withOpacity(0.6),
                              fontSize: context.scaleConfig.scaleText(16),
                            ),
                          ),
                  ),
                ),
                MaterialButton(
                  onPressed: controller.pickImage,
                  color: context.appTheme.colorScheme.primary,
                  textColor: context.appTheme.colorScheme.onPrimary,
                  padding: EdgeInsets.symmetric(
                    horizontal: context.scaleConfig.scale(16),
                    vertical: context.scaleConfig.scale(8),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(context.scaleConfig.scale(8)),
                  ),
                  child: Text(
                    "121".tr,
                    style: context.appTheme.textTheme.labelMedium!.copyWith(
                      fontSize: context.scaleConfig.scaleText(14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
