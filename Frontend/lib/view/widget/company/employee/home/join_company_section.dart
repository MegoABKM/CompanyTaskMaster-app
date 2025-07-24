import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/employee/homeemployee/employee_home_navigator_controller.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/view/widget/auth/shared/custom_button_auth.dart';
import 'package:companymanagment/view/widget/company/manager/company/shared/build_text_filed_company.dart';

class JoinCompanySection extends GetView<EmployeehomeController> {
  const JoinCompanySection({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = context.scaleConfig;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        leading: const Icon(Icons.add_business_outlined),
        title:
            Text('join_new_company'.tr, style: context.textTheme.titleMedium),
        children: [
          Padding(
            padding: EdgeInsets.all(scale.scale(16)),
            child: Column(
              children: [
                Text(
                  'enter_company_id_to_join'.tr,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: Colors.grey[600]),
                ),
                SizedBox(height: scale.scale(16)),
                BuildTextFiledCompany(
                  controller: controller.companyid,
                  label: "company_id".tr, // TRANSLATED
                  hint: "enter_id_here".tr, // TRANSLATED
                ),
                SizedBox(height: scale.scale(16)),
                CustomButtonAuth(
                  textbutton: 'send_join_request'.tr,
                  onPressed: controller.requestJoinCompany,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
