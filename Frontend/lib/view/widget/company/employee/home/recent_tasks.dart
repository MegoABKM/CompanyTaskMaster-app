import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/employee/homeemployee/employeehome_controller.dart';
import 'package:tasknotate/core/constant/imageasset.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class RecentTasks extends GetView<EmployeehomeController> {
  const RecentTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.newTaskList.length,
      itemBuilder: (context, index) {
        var newtask = controller.newTaskList[index];
        return Card(
          color: Theme.of(context).cardColor,
          margin: EdgeInsets.symmetric(
              horizontal: context.scaleConfig.scale(10),
              vertical: context.scaleConfig.scale(5)),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(context.scaleConfig.scale(10))),
          elevation: context.scaleConfig.scale(3),
          child: InkWell(
            onTap: () => controller.goToTaskDetaislEmployee(newtask),
            child: ListTile(
              leading: newtask.companyImage != null &&
                      newtask.companyImage!.isNotEmpty
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(
                          controller.getCompanyImageUrl(newtask.companyImage!)),
                      radius: context.scaleConfig.scale(25),
                    )
                  : CircleAvatar(
                      backgroundImage: AssetImage(AppImageAsset.google),
                      radius: context.scaleConfig.scale(25),
                    ),
              title: Text(
                newtask.taskTitle ??
                    '125'.tr, // No title available -> No task data available
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: context.scaleConfig.scaleText(16)),
              ),
              subtitle: Text(newtask.companyName ??
                  '228'.tr), // No company name -> No description available
              trailing: Text(
                newtask.taskCreatedOn ??
                    '136'.tr, // No date available -> Not Available
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: context.scaleConfig.scaleText(14)),
              ),
            ),
          ),
        );
      },
    );
  }
}
