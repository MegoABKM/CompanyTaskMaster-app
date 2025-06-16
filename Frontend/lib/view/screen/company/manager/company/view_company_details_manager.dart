import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/crudcompany/viewcompany_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/data/model/company/companymodel.dart';
import 'package:tasknotate/view/widget/company/manager/company/viewcompany/button_delete_view_company.dart';
import 'package:tasknotate/view/widget/company/manager/company/viewcompany/button_workspace_view_company.dart';
import 'package:tasknotate/view/widget/company/manager/company/viewcompany/employee_details_view_company.dart';
import 'package:tasknotate/view/widget/company/manager/company/viewcompany/image_section_view_company.dart';
import 'package:tasknotate/view/widget/company/manager/company/viewcompany/manager_details_section_view_company.dart';
import 'package:tasknotate/view/widget/company/manager/company/viewcompany/show_fields_section_view_company.dart';

class ViewCompanyManager extends StatelessWidget {
  const ViewCompanyManager({super.key});

  @override
  Widget build(BuildContext context) {
    final ViewcompanyController controller = Get.put(ViewcompanyController());
    final CompanyModel companyData = controller.companyData!;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "226".tr, // Company
            style: context.appTheme.textTheme.titleLarge
                ?.copyWith(fontSize: context.scaleConfig.scaleText(20)),
          ),
          actions: [
            MaterialButton(
              onPressed: () => controller.goToUpdateCompany(),
              child: Icon(FontAwesomeIcons.penToSquare,
                  size: context.scaleConfig.scale(24)),
            ),
          ],
        ),
        body: ListView(children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: context.scaleConfig.scale(20),
                vertical: context.scaleConfig.scale(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Company Image
                ImageSectionViewCompany(companyData),
                SizedBox(height: context.scaleConfig.scale(10)),
                ShowFieldsSectionViewCompany(
                  companyModel: companyData,
                ),
                SizedBox(height: context.scaleConfig.scale(20)),
                ManagerDetailsSectionViewCompany(companyModel: companyData),
                SizedBox(height: context.scaleConfig.scale(20)),
                EmployeeDetailsViewCompany(companyModel: companyData),
                SizedBox(height: context.scaleConfig.scale(20)),
                ButtonWorkspaceViewCompany(),
                SizedBox(height: context.scaleConfig.scale(10)),
                ButtonDeleteViewCompany(companyModel: companyData)
              ],
            ),
          )
        ]));
  }
}
