import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/employee/homeemployee/employeehome_controller.dart';
import 'package:tasknotate/core/class/handlingdataview.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';
import 'package:tasknotate/view/widget/company/employee/home/ad_section.dart';
import 'package:tasknotate/view/widget/company/employee/home/company_section.dart';
import 'package:tasknotate/view/widget/company/employee/home/join_company_section.dart';
import 'package:tasknotate/view/widget/company/employee/home/recent_tasks.dart';

class EmployeeHome extends StatelessWidget {
  const EmployeeHome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EmployeehomeController());
    final scaleConfig = ScaleConfig(context);

    return GetBuilder<EmployeehomeController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            "342".tr, // Welcome Employee
            style: TextStyle(fontSize: scaleConfig.scaleText(20)),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<EmployeehomeController>(
          builder: (controller) => Handlingdataview(
            statusRequest: controller.statusRequest,
            widget: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(scaleConfig.scale(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AdSectionEmployee(),
                    Text(
                      "92".tr,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: scaleConfig.scaleText(20),
                              ),
                    ),
                    SizedBox(height: scaleConfig.scale(10)),
                    if (controller.newTaskList.isNotEmpty)
                      RecentTasks()
                    else
                      Center(
                          child: Text(
                        "259".tr, // No Tasks
                        style: TextStyle(fontSize: scaleConfig.scaleText(16)),
                      )),
                    SizedBox(height: scaleConfig.scale(20)),
                    Text(
                      "343".tr, // Join a Company
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: scaleConfig.scaleText(20),
                              ),
                    ),
                    SizedBox(height: scaleConfig.scale(10)),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius:
                                BorderRadius.circular(scaleConfig.scale(10)),
                          ),
                          child: IconButton(
                            color: Colors.white,
                            iconSize: scaleConfig.scale(40),
                            onPressed: controller.toggler,
                            icon: Icon(Icons.add),
                          ),
                        ),
                        SizedBox(width: scaleConfig.scale(10)),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              "344".tr, // Join new company
                              style: TextStyle(
                                  fontSize: scaleConfig.scaleText(16)),
                            ),
                            subtitle: Text(
                              "345".tr, // Start working with a company
                              style: TextStyle(
                                  fontSize: scaleConfig.scaleText(14)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (controller.statusjoin) JoinCompanySection(),
                    SizedBox(height: scaleConfig.scale(20)),
                    Text(
                      "175".tr, // Companies
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: scaleConfig.scaleText(20),
                              ),
                    ),
                    SizedBox(height: scaleConfig.scale(10)),
                    Handlingdataview(
                      statusRequest: controller.statusRequest,
                      widget: controller.companyList.isNotEmpty
                          ? CompanySection()
                          : Center(
                              child: Text(
                                "347".tr, // No companies available
                                style: TextStyle(
                                    fontSize: scaleConfig.scaleText(16)),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
