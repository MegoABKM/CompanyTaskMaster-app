import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/data/model/company/tasks/newtasksmodel.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';
import 'package:companymanagment/core/constant/utils/scale_confige.dart';

class DescriptionSectionEmp extends StatelessWidget {
  final ThemeData theme;
  final dynamic task;

  const DescriptionSectionEmp({
    super.key,
    required this.theme,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    String description = "228".tr; // No description available

    if (task is Newtasks) {
      Newtasks newtask = task;
      description = newtask.taskDescription ?? "228".tr;
    } else if (task is TaskCompanyModel) {
      TaskCompanyModel taskcompany = task;
      description = taskcompany.description ?? "228".tr;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(scaleConfig.scale(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "276".tr, // Description
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: scaleConfig.scaleText(20),
              fontWeight: FontWeight.bold,
              color: Colors.black87, // Match manager's title color
            ),
          ),
          SizedBox(height: scaleConfig.scale(8)),
          Container(
            padding: EdgeInsets.all(scaleConfig.scale(16)),
            decoration: BoxDecoration(
              color: Colors.white, // Match manager's surface color
              borderRadius: BorderRadius.circular(scaleConfig.scale(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: scaleConfig.scale(6),
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: scaleConfig.scaleText(16),
                color: Colors.black87, // Match manager's text color
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
