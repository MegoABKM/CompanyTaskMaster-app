import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class ButtonCompany extends StatelessWidget {
  final controller;
  const ButtonCompany(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.scaleConfig.scale(10))),
        color: context.appTheme.colorScheme.secondary,
        padding: EdgeInsets.symmetric(
            horizontal: context.scaleConfig.scale(40),
            vertical: context.scaleConfig.scale(15)),
        onPressed: () => controller.createData(),
        child: Text(
          "193".tr, // Create
          style: context.appTheme.textTheme.bodyMedium!.copyWith(
            color: context.appTheme.colorScheme.onSecondary,
            fontSize: context.scaleConfig.scaleText(16),
          ),
        ),
      ),
    );
  }
}
