import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/tasks/managerhome_controller.dart';
import 'package:tasknotate/core/class/handlingdataview.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/view/widget/company/manager/home/ad_section.dart';
import 'package:tasknotate/view/widget/company/manager/home/button_create_company.dart';
import 'package:tasknotate/view/widget/company/manager/home/profile/list_company_section.dart';
import 'package:tasknotate/view/widget/company/manager/home/task_check_section_manager.dart';

class Managerpage extends StatelessWidget {
  const Managerpage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ManagerhomeController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "79".tr,
          style: context.appTheme.textTheme.titleLarge?.copyWith(
            fontSize: context.scaleConfig.scaleText(20),
          ),
        ),
      ),
      body: GetBuilder<ManagerhomeController>(
        builder: (controller) => Handlingdataview(
          statusRequest: controller.statusRequest,
          widget: ListView(
            children: [
              AdSectionManager(),
              Container(
                padding: EdgeInsets.all(context.scaleConfig.scale(16)),
                child: Column(
                  children: [
                    controller.companyData.isNotEmpty
                        ? GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  Get.width > context.scaleConfig.scale(600)
                                      ? 2
                                      : 1,
                              childAspectRatio: 1.5,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.companyData.length,
                            itemBuilder: (context, index) {
                              var company = controller.companyData[index];
                              return ListCompanySection(
                                company: company,
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              "83".tr,
                              style: context.appTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                color: context.appTheme.colorScheme.secondary,
                                fontSize: context.scaleConfig.scaleText(16),
                              ),
                            ),
                          ),
                    SizedBox(height: context.scaleConfig.scale(10)),
                    ButtonCreateCompany(),
                    SizedBox(height: context.scaleConfig.scale(20)),
                    const TaskCheckSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
