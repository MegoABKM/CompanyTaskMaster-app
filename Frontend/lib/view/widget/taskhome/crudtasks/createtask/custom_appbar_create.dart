import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/tasks/taskcreate_controller.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class CustomAppBarTaskCreate extends GetView<TaskcreateController> {
  const CustomAppBarTaskCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: context.scaleConfig.scale(50),
      padding: EdgeInsets.symmetric(horizontal: context.scaleConfig.scale(12)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: IconButton(
              color: context.appTheme.colorScheme.onSurface,
              padding: EdgeInsets.only(
                bottom: context.scaleConfig.scale(1),
                top: context.scaleConfig.scale(12),
              ),
              onPressed: () {
                controller.deleteAllImages();
                Get.offAllNamed(AppRoute.home);
              },
              icon: Icon(
                Icons.arrow_back,
                size: context.scaleConfig.scale(24),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: context.scaleConfig.scale(1),
                top: context.scaleConfig.scale(12),
              ),
              child: Text(
                "116".tr,
                style: context.appTheme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.appTheme.colorScheme.onSurface,
                  fontSize: context.scaleConfig.scaleText(20),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.topLeft,
              child: TextFormField(
                controller: controller.titlecontroller,
                style: context.appTheme.textTheme.bodyLarge!.copyWith(
                  fontSize: context.scaleConfig.scaleText(18),
                  color: context.appTheme.colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  hintStyle: context.appTheme.textTheme.bodyLarge!.copyWith(
                    color:
                        context.appTheme.colorScheme.onSurface.withOpacity(0.6),
                    fontSize: context.scaleConfig.scaleText(18),
                  ),
                  border: InputBorder.none,
                  hintText: "117".tr,
                  counterText: "",
                  contentPadding: EdgeInsets.only(
                    bottom: context.scaleConfig.scale(1),
                    top: context.scaleConfig.scale(17),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
