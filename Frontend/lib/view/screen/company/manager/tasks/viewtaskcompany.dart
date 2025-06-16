import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/tasks/viewtask_controller.dart';
import 'package:tasknotate/core/class/handlingdataview.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';
import 'package:tasknotate/view/widget/company/manager/viewtask/assignmentsection.dart';
import 'package:tasknotate/view/widget/company/manager/viewtask/descriptionsection.dart';
import 'package:tasknotate/view/widget/company/manager/viewtask/filesection.dart';
import 'package:tasknotate/view/widget/company/manager/viewtask/subtaskssection.dart';
import 'package:tasknotate/view/widget/company/manager/viewtask/taskdetails.dart';

class ViewTaskCompany extends StatelessWidget {
  const ViewTaskCompany({super.key});

  @override
  Widget build(BuildContext context) {
    final ViewTaskCompanyManagerController controller =
        Get.put(ViewTaskCompanyManagerController());
    final theme = Theme.of(context);
    final scaleConfig = ScaleConfig(context);

    return Scaffold(
      body: DefaultTabController(
        length: 5,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios,
                    color: Colors.white, size: scaleConfig.scale(24)),
                onPressed: () => Get.back(),
              ),
              title: Text(
                controller.taskcompanydetail?.title ?? "264".tr, // Task Details
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: scaleConfig.scaleText(20),
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.edit,
                      color: Colors.white, size: scaleConfig.scale(24)),
                  onPressed: () => controller.goToUpdatetask("chain"),
                ),
              ],
              backgroundColor: theme.colorScheme.primary,
              pinned: true,
              floating: true,
              elevation: 4,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(scaleConfig.scale(50)),
                child: TabBar(
                  isScrollable: true,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  indicatorColor: theme.colorScheme.secondary,
                  indicatorWeight: scaleConfig.scale(3),
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: scaleConfig.scale(16)),
                  tabs: [
                    Tab(text: "265".tr), // Details
                    Tab(text: "266".tr), // Description
                    Tab(text: "267".tr), // Assigned
                    Tab(text: "268".tr), // Subtasks
                    Tab(text: "269".tr), // Attachments
                  ]
                      .map((tab) => Tab(
                            child: Text(
                              tab.text!,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontSize: scaleConfig.scaleText(16),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
          body: GetBuilder<ViewTaskCompanyManagerController>(
            builder: (controller) => Handlingdataview(
              statusRequest: controller.statusRequest,
              widget: Container(
                color: theme.scaffoldBackgroundColor,
                child: TabBarView(
                  children: [
                    _buildTabContent(TaskDetails(theme: theme), scaleConfig),
                    _buildTabContent(
                        DescriptionSection(theme: theme), scaleConfig),
                    _buildTabContent(
                        AssignedUsersSection(theme: theme), scaleConfig),
                    _buildTabContent(
                        SubtasksSection(theme: theme), scaleConfig),
                    _buildTabContent(
                        AttachmentsSection(theme: theme), scaleConfig),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(Widget child, ScaleConfig scaleConfig) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(scaleConfig.scale(16)),
      child: Card(
        elevation: scaleConfig.scale(2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(scaleConfig.scale(16)),
        ),
        child: Padding(
          padding: EdgeInsets.all(scaleConfig.scale(16)),
          child: child,
        ),
      ),
    );
  }
}
