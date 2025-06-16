import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/tasks/taskcreate_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class SwitchAndWidget extends GetView<TaskcreateController> {
  final String nameofswitch;
  final String typeofswitch;
  final bool valueofswitch;
  final Widget widget;

  const SwitchAndWidget(
    this.nameofswitch,
    this.typeofswitch,
    this.valueofswitch,
    this.widget, {
    super.key,
    required ThemeData theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: context.scaleConfig.scale(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              nameofswitch,
              style: context.appTheme.textTheme.bodyLarge!.copyWith(
                color: context.appTheme.colorScheme.onSurface,
                fontSize: context.scaleConfig.scaleText(18),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(right: context.scaleConfig.scale(10)),
              child: Switch.adaptive(
                inactiveTrackColor: context.appTheme.colorScheme.onSurface,
                inactiveThumbColor:
                    context.appTheme.colorScheme.primaryContainer,
                activeColor: context.appTheme.colorScheme.primary,
                activeTrackColor: Colors.greenAccent,
                value: valueofswitch,
                onChanged: (value) {
                  controller.switchstatusbutton(value, typeofswitch);
                },
              ),
            ),
          ),
          if (valueofswitch) Expanded(flex: 3, child: widget),
        ],
      ),
    );
  }
}
