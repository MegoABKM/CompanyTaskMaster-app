import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tasknotate/controller/home_controller.dart';
import 'package:tasknotate/core/constant/utils/extensions.dart';
import 'package:tasknotate/view/widget/taskhome/home/empty_task_message.dart';
import 'package:tasknotate/view/widget/taskhome/home/task_list/customtaskcard/task_dialog.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineHome extends StatelessWidget {
  const TimelineHome({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeDateFormatting('ar', null),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        }

        return GetBuilder<HomeController>(
          id: 'timeline-view',
          builder: (controller) {
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
                    final hasStartTime =
                        task.starttime != null && task.starttime != "Not Set";

                    final timelineMarker = hasStartTime &&
                            task.starttime != null
                        ? DateFormat('dd MMMM yyyy, HH:mm', 'ar')
                            .format(DateTime.parse(task.starttime!))
                        : "${'362'.tr}: ${task.date != null ? DateFormat('dd MMMM yyyy', 'ar').format(DateTime.parse(task.date!)) : '363'.tr}";

                    final statusColor = _getStatusColor(task.status);

                    return TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineXY: 0.3,
                      isFirst: index == 0,
                      isLast: index == controller.taskdata.length - 1,
                      indicatorStyle: IndicatorStyle(
                        width: context.scaleConfig.scale(20),
                        color: statusColor,
                        padding: EdgeInsets.symmetric(
                            vertical: context.scaleConfig.scale(5)),
                      ),
                      startChild: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.scaleConfig.scale(8),
                          vertical: context.scaleConfig.scale(8),
                        ),
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          timelineMarker,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                fontSize: context.scaleConfig.scaleText(14),
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      endChild: GestureDetector(
                        onLongPress: () => TaskDialogHelper.showTaskDialog(
                            context, task, context.scaleConfig, controller),
                        onTap: () =>
                            controller.goToViewTask(task, index.toString()),
                        child: Container(
                          padding:
                              EdgeInsets.all(context.scaleConfig.scale(16)),
                          margin: EdgeInsets.symmetric(
                            vertical: context.scaleConfig.scale(8),
                            horizontal: context.scaleConfig.scale(16),
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.surface,
                                Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withOpacity(0.8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(
                                context.scaleConfig.scale(12)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: context.scaleConfig.scale(4),
                                offset: Offset(0, context.scaleConfig.scale(2)),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.title ?? "Untitled".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontSize: context.scaleConfig
                                                .scaleText(16),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    if (!hasStartTime)
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: context.scaleConfig.scale(8)),
                                        child: Text(
                                          "361".tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                fontSize: context.scaleConfig
                                                    .scaleText(14),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface
                                                    .withOpacity(0.7),
                                              ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: context.scaleConfig.scale(20),
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                      beforeLineStyle: LineStyle(
                        color: statusColor,
                        thickness: context.scaleConfig.scale(2),
                      ),
                      afterLineStyle: LineStyle(
                        color: statusColor,
                        thickness: context.scaleConfig.scale(2),
                      ),
                    );
                  }
                  return SizedBox(height: 80 * context.scaleConfig.scaleHeight);
                },
                childCount: controller.taskdata.length + 1,
              ),
            );
          },
        );
      },
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case "Pending":
        return Colors.yellow;
      case "In Progress":
        return Colors.blue;
      case "Completed":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
