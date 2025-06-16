import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/employee/homeemployee/viewcompany_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/data/model/company/companymodel.dart';
import 'package:tasknotate/view/widget/company/employee/company/description_company.dart';
import 'package:tasknotate/view/widget/company/employee/company/employee_company.dart';
import 'package:tasknotate/view/widget/company/employee/company/manager_company.dart';
import 'package:tasknotate/view/widget/company/employee/company/nick_id_company.dart';
import 'package:tasknotate/view/widget/company/employee/company/image_company.dart';
import 'package:tasknotate/view/widget/company/employee/company/title_company.dart';
import 'package:tasknotate/view/widget/company/employee/company/workspace_navigate_company.dart';

class ViewCompanyEmployee extends StatelessWidget {
  const ViewCompanyEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    final ViewcompanyEmployeeController controller =
        Get.put(ViewcompanyEmployeeController());
    final CompanyModel companyModel = controller.companyData!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "226".tr, // Company
          style: TextStyle(fontSize: context.scaleConfig.scaleText(20)),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: context.scaleConfig.scale(20),
                vertical: context.scaleConfig.scale(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageCompany(
                  companyModel: companyModel,
                ),
                SizedBox(height: context.scaleConfig.scale(10)),
                TitleCompany(
                  companyModel: companyModel,
                ),
                SizedBox(height: context.scaleConfig.scale(10)),
                NickIdCompany(
                  companyModel: companyModel,
                ),
                SizedBox(height: context.scaleConfig.scale(10)),
                DescriptionCompany(
                  companyModel: companyModel,
                ),
                SizedBox(height: context.scaleConfig.scale(20)),
                ManagerCompany(companyModel: companyModel),
                SizedBox(height: context.scaleConfig.scale(20)),
                EmployeeCompany(
                  companyModel: companyModel,
                ),
                SizedBox(height: context.scaleConfig.scale(20)),
                WorkspaceNavigateCompany()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
