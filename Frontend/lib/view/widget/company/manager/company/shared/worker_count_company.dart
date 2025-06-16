import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class WorkerCountCompany extends StatelessWidget {
  final controller;
  const WorkerCountCompany({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        "192".tr, // How many people work here?
        style: context.appTheme.textTheme.titleMedium
            ?.copyWith(fontSize: context.scaleConfig.scaleText(18)),
      ),
      SizedBox(height: context.scaleConfig.scale(10)),
      ListView.builder(
        shrinkWrap: true,
        itemCount: controller.options.length,
        itemBuilder: (context, index) {
          final isSelected = controller.selectedIndex == index;
          return InkWell(
            onTap: () => controller.selectOption(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isSelected
                  ? context.scaleConfig.scale(70)
                  : context.scaleConfig.scale(40),
              margin:
                  EdgeInsets.symmetric(vertical: context.scaleConfig.scale(5)),
              decoration: BoxDecoration(
                color: isSelected
                    ? context.appTheme.colorScheme.secondary
                    : context.appTheme.cardColor,
                borderRadius:
                    BorderRadius.circular(context.scaleConfig.scale(10)),
              ),
              child: Center(
                child: Text(
                  controller.options[index],
                  style: context.appTheme.textTheme.bodyMedium!.copyWith(
                    color: isSelected
                        ? context.appTheme.colorScheme.onPrimary
                        : context.appTheme.colorScheme.onSurface,
                    fontSize: context.scaleConfig.scaleText(16),
                  ),
                ),
              ),
            ),
          );
        },
      )
    ]);
  }
}
