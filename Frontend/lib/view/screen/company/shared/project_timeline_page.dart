// lib/view/screen/company/shared/project_timeline_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';
import 'package:companymanagment/data/model/company/project_model.dart';
import 'package:companymanagment/data/model/company/sprint_model.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';
import 'package:intl/intl.dart';
import 'package:companymanagment/view/widget/company/manager/home/empty_state_widget.dart';

// Helper class
class TimelineEvent {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final Color color;
  final IconData icon;
  final bool isMilestone;

  TimelineEvent({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.color,
    required this.icon,
    this.isMilestone = false,
  });
}

class ProjectTimelinePage extends StatefulWidget {
  const ProjectTimelinePage({super.key});

  @override
  State<ProjectTimelinePage> createState() => _ProjectTimelinePageState();
}

class _ProjectTimelinePageState extends State<ProjectTimelinePage> {
  List<TimelineEvent> _processedEvents = [];
  DateTime? _projectStartDate;
  int _totalDays = 0;
  bool _isDataProcessed = false;

  late double _dayWidth;
  late double _rowHeight;
  late double _headerHeight;
  late double _leftColumnWidth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isDataProcessed) {
      _processDataForTimeline();
      _isDataProcessed = true;
    }
  }

  void _processDataForTimeline() {
    // This logic remains the same as the previous version
    final ProjectModel project = Get.arguments['project'];
    final List<SprintModel> sprints = Get.arguments['sprints'];
    final List<TaskCompanyModel> allTasks = Get.arguments['tasks'];
    final theme = Theme.of(context);
    List<TimelineEvent> events = [];
    List<DateTime> allDates = [];
    final List<TaskCompanyModel> projectTasks = allTasks
        .where((task) => task.projectId == project.projectId.toString())
        .toList();

    for (var sprint in sprints) {
      final startDate = DateTime.tryParse(sprint.startDate ?? '');
      final endDate = DateTime.tryParse(sprint.endDate ?? '');
      if (startDate != null && endDate != null) {
        allDates.add(startDate);
        allDates.add(endDate);
        events.add(TimelineEvent(
          title: sprint.sprintName ?? 'unnamed_sprint'.tr,
          startDate: startDate,
          endDate: endDate,
          color: Colors.amber.shade700,
          icon: Icons.sync_alt,
        ));
      }
    }

    for (var task in projectTasks) {
      final startDate =
          DateTime.tryParse(task.startDate ?? task.createdOn ?? '');
      final dueDate = DateTime.tryParse(task.dueDate ?? '');
      if (startDate != null) {
        allDates.add(startDate);
        if (dueDate != null) allDates.add(dueDate);
        events.add(TimelineEvent(
          title: task.title ?? 'untitled_task'.tr,
          startDate: startDate,
          endDate: dueDate ?? startDate.add(const Duration(days: 1)),
          color: task.status == 'Completed'
              ? Colors.green.shade600
              : theme.colorScheme.primary,
          icon: Icons.task_alt,
        ));
      }
    }

    final projectDeadline = DateTime.tryParse(project.deadline ?? '');
    if (projectDeadline != null) {
      allDates.add(projectDeadline);
      events.add(TimelineEvent(
          title: 'project_deadline'.tr,
          startDate: projectDeadline,
          endDate: projectDeadline,
          color: theme.colorScheme.error,
          icon: Icons.flag,
          isMilestone: true));
    }

    if (allDates.isEmpty) {
      setState(() => _processedEvents = []);
      return;
    }

    events.sort((a, b) => a.startDate.compareTo(b.startDate));
    allDates.sort((a, b) => a.compareTo(b));
    _projectStartDate = allDates.first.subtract(const Duration(days: 2));
    DateTime projectEndDate = allDates.last.add(const Duration(days: 5));
    _totalDays = projectEndDate.difference(_projectStartDate!).inDays;
    setState(() => _processedEvents = events);
  }

  @override
  Widget build(BuildContext context) {
    final ProjectModel project = Get.arguments['project'];
    final theme = Theme.of(context);
    final scale = context.scaleConfig;
    final isLandscape = context.isLandscape;

    _dayWidth = scale.scale(isLandscape ? 60 : 50);
    _rowHeight = scale.scale(isLandscape ? 50 : 45);
    _headerHeight = scale.scale(60);
    _leftColumnWidth = scale.scale(isLandscape ? 0 : 180);

    if (!_isDataProcessed) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${project.projectName} - ${'timeline'.tr}'),
      ),
      body: _processedEvents.isEmpty || _projectStartDate == null
          ? EmptyStateWidget(
              icon: Icons.timeline_outlined,
              message: 'no_timeline_data'.tr,
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isLandscape) _buildEventNameColumn(theme),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: _totalDays * _dayWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDateHeader(theme),
                          const Divider(height: 1, thickness: 1),
                          Expanded(
                            // --- THE FIX IS HERE ---
                            // In portrait mode, we wrap the content in a Stack.
                            // In landscape, a simple ListView.builder is correct.
                            child: isLandscape
                                ? _buildLandscapeContent(theme)
                                : _buildPortraitContent(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  // Build method for Portrait mode content, using a Stack
  Widget _buildPortraitContent() {
    return Stack(
      children: [
        // This ListView builds the background rows
        ListView.builder(
          itemCount: _processedEvents.length,
          itemBuilder: (context, index) {
            return Container(
              height: _rowHeight,
              decoration: BoxDecoration(
                  color: index.isEven
                      ? Theme.of(context).cardColor
                      : Theme.of(context).dividerColor.withOpacity(0.1),
                  border: Border(
                      bottom:
                          BorderSide(color: Theme.of(context).dividerColor))),
            );
          },
        ),
        // This generates all the event bars on top of the background rows
        ...List.generate(_processedEvents.length, (index) {
          return _buildPortraitEventBar(_processedEvents[index], index);
        }),
      ],
    );
  }

  // Build method for Landscape mode content (remains the same)
  Widget _buildLandscapeContent(ThemeData theme) {
    return ListView.builder(
      itemCount: _processedEvents.length,
      itemBuilder: (context, index) {
        return _buildLandscapeEventBar(_processedEvents[index], index, theme);
      },
    );
  }

  // --- All other helper methods (_buildEventNameColumn, _buildDateHeader, etc.) remain exactly the same as the previous full version ---
  Widget _buildEventNameColumn(ThemeData theme) {
    final scale = context.scaleConfig;
    return SizedBox(
      width: _leftColumnWidth,
      child: Column(
        children: [
          SizedBox(height: _headerHeight),
          const Divider(height: 1, thickness: 1),
          Expanded(
            child: ListView.builder(
              itemCount: _processedEvents.length,
              itemBuilder: (context, index) {
                final event = _processedEvents[index];
                return Container(
                  height: _rowHeight,
                  padding: EdgeInsets.only(left: scale.scale(8)),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: index.isEven
                          ? theme.cardColor
                          : theme.dividerColor.withOpacity(0.1),
                      border: Border(
                          bottom: BorderSide(color: theme.dividerColor))),
                  child: Row(
                    children: [
                      Icon(event.icon,
                          size: scale.scale(18), color: event.color),
                      SizedBox(width: scale.scale(8)),
                      Expanded(
                        child: Text(
                          event.title,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(fontSize: scale.scaleText(12)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateHeader(ThemeData theme) {
    Map<String, int> monthDays = {};
    if (_projectStartDate == null) return const SizedBox.shrink();

    DateTime currentDate = _projectStartDate!;
    for (int i = 0; i < _totalDays; i++) {
      final monthKey =
          DateFormat.yMMM(Get.locale?.languageCode).format(currentDate);
      monthDays.update(monthKey, (value) => value + 1, ifAbsent: () => 1);
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return SizedBox(
      height: _headerHeight,
      child: Column(
        children: [
          Row(
            children: monthDays.entries.map((entry) {
              return Container(
                width: entry.value * _dayWidth,
                height: _headerHeight / 2,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Colors.grey.shade300),
                        bottom: BorderSide(color: Colors.grey.shade300))),
                child: Text(entry.key,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
              );
            }).toList(),
          ),
          Row(
            children: List.generate(_totalDays, (index) {
              final date = _projectStartDate!.add(Duration(days: index));
              final isToday = DateUtils.isSameDay(date, DateTime.now());
              return Container(
                width: _dayWidth,
                height: _headerHeight / 2,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border:
                      Border(right: BorderSide(color: Colors.grey.shade200)),
                  color: isToday ? theme.primaryColor.withOpacity(0.1) : null,
                ),
                child: Text(DateFormat.d().format(date),
                    style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight:
                            isToday ? FontWeight.bold : FontWeight.normal,
                        color: isToday ? theme.primaryColor : null)),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildPortraitEventBar(TimelineEvent event, int rowIndex) {
    if (_projectStartDate == null) return const SizedBox.shrink();
    final scale = context.scaleConfig;
    final offset =
        event.startDate.difference(_projectStartDate!).inDays * _dayWidth;
    final durationInDays = event.endDate.difference(event.startDate).inDays;
    final width = (durationInDays >= 0 ? durationInDays + 1 : 1) * _dayWidth;

    return Positioned(
      left: offset,
      top: (rowIndex * _rowHeight) + scale.scale(7.5),
      child: Tooltip(
        message:
            "${event.title}\n${DateFormat.yMMMd().format(event.startDate)} - ${DateFormat.yMMMd().format(event.endDate)}",
        child: Container(
          height: _rowHeight - scale.scale(15),
          width: event.isMilestone ? _rowHeight - scale.scale(15) : width,
          decoration: BoxDecoration(
              color: event.isMilestone ? Colors.transparent : event.color,
              borderRadius: BorderRadius.circular(event.isMilestone ? 50 : 8),
              border: event.isMilestone
                  ? Border.all(color: event.color, width: 2.5)
                  : null,
              boxShadow: [
                if (!event.isMilestone)
                  BoxShadow(
                      color: event.color.withOpacity(0.5),
                      blurRadius: 6,
                      offset: const Offset(0, 3))
              ]),
          child: event.isMilestone
              ? Center(
                  child: Icon(event.icon,
                      color: event.color, size: scale.scale(18)))
              : null,
        ),
      ),
    );
  }

  Widget _buildLandscapeEventBar(
      TimelineEvent event, int rowIndex, ThemeData theme) {
    if (_projectStartDate == null) return const SizedBox.shrink();
    final scale = context.scaleConfig;
    final offset =
        event.startDate.difference(_projectStartDate!).inDays * _dayWidth;
    final durationInDays = event.endDate.difference(event.startDate).inDays;
    final width = (durationInDays >= 0 ? durationInDays + 1 : 1) * _dayWidth;

    return Container(
      height: _rowHeight,
      decoration: BoxDecoration(
          color: rowIndex.isEven
              ? theme.cardColor
              : theme.dividerColor.withOpacity(0.1),
          border: Border(bottom: BorderSide(color: theme.dividerColor))),
      child: Stack(
        clipBehavior:
            Clip.none, // Allow drawing outside the bounds of the Stack
        children: [
          Positioned(
            left: offset,
            top: scale.scale(7.5),
            child: Tooltip(
              message:
                  "${event.title}\n${DateFormat.yMMMd().format(event.startDate)} - ${DateFormat.yMMMd().format(event.endDate)}",
              child: Container(
                height: _rowHeight - scale.scale(15),
                width: event.isMilestone ? _rowHeight - scale.scale(15) : width,
                padding: EdgeInsets.symmetric(horizontal: scale.scale(8)),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: event.isMilestone ? Colors.transparent : event.color,
                    borderRadius:
                        BorderRadius.circular(event.isMilestone ? 50 : 8),
                    border: event.isMilestone
                        ? Border.all(color: event.color, width: 2.5)
                        : null,
                    boxShadow: [
                      if (!event.isMilestone)
                        BoxShadow(
                            color: event.color.withOpacity(0.5),
                            blurRadius: 6,
                            offset: const Offset(0, 3))
                    ]),
                child: event.isMilestone
                    ? Center(
                        child: Icon(event.icon,
                            color: event.color, size: scale.scale(18)))
                    : Text(
                        event.title,
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white, fontSize: scale.scaleText(12)),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
