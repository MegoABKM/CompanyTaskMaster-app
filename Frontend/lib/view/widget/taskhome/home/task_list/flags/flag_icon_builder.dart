// lib/view/widget/taskhome/task_list/flags/flagiconbuilder.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';
import 'package:tasknotate/core/services/services.dart';
import 'package:tasknotate/data/model/usertasksmodel.dart';
import 'package:tasknotate/view/widget/taskhome/home/task_list/flags/flag.dart';

class FlagIconBuilder {
  final UserTasksModel task;
  final ScaleConfig scale;
  final BuildContext context;

  FlagIconBuilder({
    required this.task,
    required this.scale,
    required this.context,
  });

  List<Widget> build() {
    final MyServices myServices = Get.find<MyServices>();
    final String? lang = myServices.sharedPreferences.getString("lang");
    final bool isRTL = lang == "ar";

    final conditions = [
      task.subtask != "Not Set" && task.subtask != "{}",
      task.reminder != "Not Set",
      task.images != "Not Set" && task.images != "{}",
    ];
    final icons = [
      FontAwesomeIcons.list,
      FontAwesomeIcons.clock,
      FontAwesomeIcons.fileImage,
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final leftPositionRatios = [
      0.85,
      0.75,
      0.80,
    ];

    final flagWidth = scale.scale(30);
    final flagGap = scale.scale(5); // Add a small gap between flags
    final totalFlags = conditions.where((condition) => condition).length;
    // ignore: unused_local_variable
    final totalFlagsWidth =
        totalFlags * (flagWidth + flagGap) - flagGap; // Subtract the last gap

    final List<double> leftPositions;
    if (isRTL) {
      // For RTL (Arabic), position flags from left to right with a gap
      leftPositions = List.generate(
        conditions.length,
        (index) => (index * (flagWidth + flagGap)) + scale.scale(10),
      );
    } else {
      // For LTR (default), position flags from right to left with a gap
      leftPositions = leftPositionRatios
          .map((ratio) => screenWidth * ratio - scale.scale(30))
          .toList();
    }

    return List.generate(
      conditions.length,
      (index) => conditions[index]
          ? FlagIcon(
              typeflag: "flagged",
              leftpostion: leftPositions[index],
              iconforflag: icons[index],
              colorflag: Colors.red,
            )
          : null,
    ).whereType<Widget>().toList();
  }
}
