import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/employee/tasks/viewtaskemp_controller.dart';
import 'package:tasknotate/core/class/handlingdataview.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/view/widget/company/employee/viewtask/assignment_user_section_employee.dart';
import 'package:tasknotate/view/widget/company/employee/viewtask/description_section_employee.dart';
import 'package:tasknotate/view/widget/company/employee/viewtask/attachments_section_employee.dart';
import 'package:tasknotate/view/widget/company/employee/viewtask/subtasks_section_employee.dart';
import 'package:tasknotate/view/widget/company/employee/viewtask/task_details_employee.dart';

class ViewTaskCompanyEmployee extends StatefulWidget {
  const ViewTaskCompanyEmployee({super.key});
  @override
  _ViewTaskCompanyEmployeeState createState() =>
      _ViewTaskCompanyEmployeeState();
}

class _ViewTaskCompanyEmployeeState extends State<ViewTaskCompanyEmployee>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ViewtaskEmpController controller = Get.put(ViewtaskEmpController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: context.scaleConfig.scale(24)),
          onPressed: () {
            if (controller.from == "employee") {
              controller.goToHome();
            } else {
              controller.goToWorkSpace();
            }
          },
        ),
        centerTitle: true,
        title: Text(
          "264".tr, // Task Details
          style: TextStyle(
            fontSize: context.scaleConfig.scaleText(20),
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: context.appTheme.colorScheme.primary,
          labelColor: context.appTheme.colorScheme.primary,
          unselectedLabelColor:
              Colors.grey[700], // Match manager's unselected color
          labelStyle: TextStyle(fontSize: context.scaleConfig.scaleText(14)),
          tabs: [
            Tab(text: "126".tr), // Task Details
            Tab(text: "276".tr), // Description
            Tab(text: "267".tr), // Assigned Users
            Tab(text: "311".tr), // Subtasks
            Tab(text: "269".tr), // Attachments
          ],
        ),
      ),
      body: GetBuilder<ViewtaskEmpController>(
        builder: (controller) {
          final task =
              (controller.from == "employee" && controller.newtasks != null)
                  ? controller.newtasks
                  : controller.taskcompanydetail;
          return Handlingdataview(
            statusRequest: controller.statusRequest,
            widget: TabBarView(
              controller: _tabController,
              children: [
                TaskDetailsEmployee(theme: context.appTheme, task: task),
                DescriptionSectionEmp(theme: context.appTheme, task: task),
                AssignedUsersSectionEmp(theme: context.appTheme),
                SubtasksSectionEmp(theme: context.appTheme),
                AttachmentsSectionEmp(theme: context.appTheme),
              ],
            ),
          );
        },
      ),
    );
  }
}
