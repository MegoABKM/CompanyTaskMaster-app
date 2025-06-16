import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/home_controller.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/view/widget/taskhome/home/categoires_task_drawer.dart';
import 'package:tasknotate/view/widget/taskhome/home/category_dropdown.dart';
import 'package:tasknotate/view/widget/taskhome/home/task_timeline/timeline_task_home.dart';
import 'package:tasknotate/view/widget/taskhome/home/animate_app_bar_task.dart';
import 'package:tasknotate/view/widget/taskhome/home/custom_float_button_task.dart';
import 'package:tasknotate/view/widget/taskhome/home/empty_task_message.dart';
import 'package:tasknotate/view/widget/taskhome/home/sort_drop_down.dart';
import 'package:tasknotate/view/widget/taskhome/home/task_list/task_item.dart';

class Taskshome extends StatelessWidget {
  const Taskshome({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Scaffold(
      floatingActionButton: CustomFloatButtonTask(
        onPressed: () => Get.toNamed(AppRoute.createTask),
      ),
      drawer: CategoryDrawerTask(
        controller: controller,
        isTaskDrawer: true,
      ),
      body: CustomScrollView(
        slivers: [
          const AnimateAppBarTask(),
          GetBuilder<HomeController>(
            id: 'sort-view',
            builder: (controller) => SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: context.scaleConfig.scale(8.0),
                  horizontal: context.scaleConfig.scale(24.0),
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround, // Changed to start
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: !controller.isTimelineView
                                ? context.appTheme.colorScheme.secondary
                                : Colors.grey.shade300,
                            borderRadius: BorderRadiusDirectional.only(
                              topStart:
                                  Radius.circular(context.scaleConfig.scale(8)),
                              bottomStart:
                                  Radius.circular(context.scaleConfig.scale(8)),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () => controller.toggleTaskView(false),
                            icon: Icon(
                              FontAwesomeIcons.listCheck,
                              color: !controller.isTimelineView
                                  ? context.appTheme.colorScheme.onSecondary
                                  : Colors.grey.shade600,
                              size: context.scaleConfig.scale(20),
                            ),
                            tooltip: 'List View'.tr,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: controller.isTimelineView
                                ? context.appTheme.colorScheme.secondary
                                : Colors.grey.shade300,
                            borderRadius: BorderRadiusDirectional.only(
                              topEnd:
                                  Radius.circular(context.scaleConfig.scale(8)),
                              bottomEnd:
                                  Radius.circular(context.scaleConfig.scale(8)),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () => controller.toggleTaskView(true),
                            icon: Icon(
                              FontAwesomeIcons.timeline,
                              color: controller.isTimelineView
                                  ? context.appTheme.colorScheme.onSecondary
                                  : Colors.grey.shade600,
                              size: context.scaleConfig.scale(20),
                            ),
                            tooltip: 'Timeline View'.tr,
                          ),
                        ),
                      ],
                    ),
                    CategoryDropdown(
                      controller: controller,
                      scale: context.scaleConfig,
                    ),
                    SortDropdown(
                      controller: controller,
                      scale: context.scaleConfig,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GetBuilder<HomeController>(
            id: 'task-view',
            builder: (controller) {
              if (controller.isLoadingTasks) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (controller.isTimelineView) {
                return const TimelineHome();
              } else {
                if (controller.taskdata.isEmpty) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: EmptyTaskMessage(),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < controller.taskdata.length) {
                        final task = controller.taskdata[index];
                        return TaskItem(
                          task: task,
                          index: index,
                          scale: context.scaleConfig,
                        );
                      }
                      return SizedBox(
                          height: 80 * context.scaleConfig.scaleHeight);
                    },
                    childCount: controller.taskdata.length + 1,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
