import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/employee/homeemployee/employeehome_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';

class JoinCompanySection extends GetView<EmployeehomeController> {
  const JoinCompanySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.scaleConfig.scale(10)),
      child: Column(
        children: [
          TextFormField(
            controller: controller.companyid,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(context.scaleConfig.scale(10)))),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: context.scaleConfig.scale(20),
                  vertical: context.scaleConfig.scale(10)),
              hintText: "185".tr, // Enter company ID
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
            ),
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: context.scaleConfig.scaleText(16)),
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: context.scaleConfig.scale(10)),
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(context.scaleConfig.scale(10))),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: controller.requestJoinCompany,
            child: Text(
              "346".tr, // Send Request
              style: TextStyle(fontSize: context.scaleConfig.scaleText(16)),
            ),
          ),
        ],
      ),
    );
  }
}
