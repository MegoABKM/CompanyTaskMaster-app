// import 'dart:async';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:companymanagment/data/datasource/local/sqldb.dart';
// import 'package:companymanagment/data/model/usertasksmodel.dart';

// class BackgroundService {
//   static final FlutterBackgroundService _service = FlutterBackgroundService();
//   static final SqlDb _sqlDb = SqlDb();
//   static final Map<String, UserTasksModel> _activeTasks = {};
//   static final Map<String, int> _elapsedTimes = {};
//   static final Map<String, DateTime?> _startTimes = {};
//   static final Map<String, Timer?> _timers = {};
//   static String? _lastNotificationContent;

//   static Future<void> initializeService() async {
//     try {
//       await _service.configure(
//         androidConfiguration: AndroidConfiguration(
//           onStart: onStart,
//           autoStart: false,
//           isForegroundMode: true,
//           notificationChannelId: 'companymanagment_stopwatch',
//           initialNotificationTitle: 'companymanagment Service',
//           initialNotificationContent: 'Running in background',
//           foregroundServiceNotificationId: 999, // Separate ID for foreground
//           foregroundServiceTypes: [AndroidForegroundType.specialUse],
//         ),
//         iosConfiguration: IosConfiguration(
//           autoStart: false,
//           onForeground: onStart,
//           onBackground: onIosBackground,
//         ),
//       );
//       print('BackgroundService initialized successfully');
//     } catch (e) {
//       print('Error initializing BackgroundService: $e');
//     }
//   }

//   @pragma('vm:entry-point')
//   static void onStart(ServiceInstance service) async {
//     if (service is AndroidServiceInstance) {
//       service.on('setAsForeground').listen((event) {
//         service.setAsForegroundService();
//       });
//       service.on('setAsBackground').listen((event) {
//         service.setAsBackgroundService();
//       });
//     }

//     service.on('stopService').listen((event) async {
//       try {
//         final taskId = event?['taskId']?.toString();
//         if (taskId != null) {
//           await _stopTask(taskId);
//           print('BackgroundService stopped for task $taskId');
//         } else {
//           await _stopAllTasks();
//           print('BackgroundService stopped for all tasks');
//         }
//         if (_activeTasks.isEmpty) {
//           service.stopSelf();
//         }
//       } catch (e) {
//         print('Error stopping service: $e');
//       }
//     });

//     service.on('updateTask').listen((event) async {
//       if (event == null || event['task'] == null) {
//         print('updateTask event or task is null');
//         return;
//       }
//       try {
//         final task = UserTasksModel.fromJson(event['task']);
//         final taskId = task.id!;
//         final status = event['status']?.toString() ?? task.status ?? 'Pending';
//         print('updateTask: task=${task.title}, id=$taskId, status=$status');

//         _activeTasks[taskId] = task;
//         _elapsedTimes[taskId] = task.stopwatchElapsed ?? 0;

//         if (task.stopwatchEnabled == 1) {
//           if (status == 'In Progress') {
//             _startTimes[taskId] = DateTime.now();
//             _timers[taskId]?.cancel();
//             _timers[taskId] =
//                 Timer.periodic(const Duration(seconds: 5), (timer) async {
//               if (!_activeTasks.containsKey(taskId)) {
//                 timer.cancel();
//                 return;
//               }
//               _elapsedTimes[taskId] = _activeTasks[taskId]!.stopwatchElapsed! +
//                   DateTime.now().difference(_startTimes[taskId]!).inSeconds;
//               await _updateNotification(taskId);
//               service.invoke('updateElapsedTime', {
//                 'taskId': taskId,
//                 'elapsedTime': _elapsedTimes[taskId],
//               });
//             });
//             print('Stopwatch started for task ${task.title} (ID: $taskId)');
//           } else {
//             await _pauseTask(taskId);
//             print(
//                 'Stopwatch paused/stopped for task ${task.title} (ID: $taskId)');
//           }
//         } else {
//           await clearNotification(taskId);
//         }
//       } catch (e) {
//         print('Error in updateTask: $e');
//       }
//     });

//     service.on('updateStatus').listen((event) async {
//       if (event == null || event['taskId'] == null) {
//         print('updateStatus event or taskId is null');
//         return;
//       }
//       try {
//         final taskId = event['taskId'].toString();
//         final newStatus = event['status'].toString();
//         if (!_activeTasks.containsKey(taskId)) {
//           print('Task $taskId not found in active tasks');
//           return;
//         }
//         _activeTasks[taskId] = UserTasksModel(
//           id: _activeTasks[taskId]?.id,
//           title: _activeTasks[taskId]?.title,
//           content: _activeTasks[taskId]?.content,
//           date: _activeTasks[taskId]?.date,
//           estimatetime: _activeTasks[taskId]?.estimatetime,
//           starttime: _activeTasks[taskId]?.starttime,
//           reminder: _activeTasks[taskId]?.reminder,
//           status: newStatus,
//           priority: _activeTasks[taskId]?.priority,
//           subtask: _activeTasks[taskId]?.subtask,
//           checked: _activeTasks[taskId]?.checked,
//           images: _activeTasks[taskId]?.images,
//           timeline: _activeTasks[taskId]?.timeline,
//           category: _activeTasks[taskId]?.category,
//           stopwatchEnabled: _activeTasks[taskId]?.stopwatchEnabled,
//           stopwatchElapsed: _elapsedTimes[taskId],
//         );
//         await _updateDatabase(taskId);
//         service.invoke('updateTask', {
//           'task': _activeTasks[taskId]!.toJson(),
//           'status': newStatus,
//           'taskId': taskId,
//         });
//         print('Status updated to $newStatus for task $taskId');
//       } catch (e) {
//         print('Error in updateStatus: $e');
//       }
//     });
//   }

//   @pragma('vm:entry-point')
//   static Future<bool> onIosBackground(ServiceInstance service) async {
//     return true;
//   }

//   static Future<void> startService(UserTasksModel task) async {
//     try {
//       final taskId = task.id!;
//       _activeTasks[taskId] = task;
//       _elapsedTimes[taskId] = task.stopwatchElapsed ?? 0;
//       await _service.startService();
//       _service.invoke('updateTask', {
//         'task': task.toJson(),
//         'status': task.status,
//         'taskId': taskId,
//       });
//       print('BackgroundService started for task ${task.title} (ID: $taskId)');
//     } catch (e) {
//       print('Error starting BackgroundService: $e');
//     }
//   }

//   static Future<void> stopService(String? taskId) async {
//     try {
//       if (taskId != null) {
//         _service.invoke('stopService', {'taskId': taskId});
//         print('BackgroundService stop requested for task $taskId');
//       } else {
//         _service.invoke('stopService');
//         print('BackgroundService stop requested for all tasks');
//       }
//     } catch (e) {
//       print('Error stopping BackgroundService: $e');
//     }
//   }

//   static Future<void> updateStatus(String status, String? taskId) async {
//     try {
//       if (taskId != null) {
//         _service.invoke('updateStatus', {
//           'status': status,
//           'taskId': taskId,
//         });
//         print('BackgroundService updateStatus: $status for task $taskId');
//       } else {
//         print('Cannot update status: taskId is null');
//       }
//     } catch (e) {
//       print('Error updating status: $e');
//     }
//   }

//   static Future<void> clearNotification(String taskId) async {
//     try {
//       final notificationId = taskId.hashCode;
//       final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//       await flutterLocalNotificationsPlugin.cancel(notificationId);
//       print('Notification cleared for task $taskId (ID: $notificationId)');
//     } catch (e) {
//       print('Error clearing notification for task $taskId: $e');
//     }
//   }

//   static Future<void> _updateDatabase(String taskId) async {
//     if (!_activeTasks.containsKey(taskId)) {
//       print('No task $taskId to update in database');
//       return;
//     }
//     try {
//       int response = await _sqlDb.updateData(
//         "UPDATE tasks SET stopwatch_elapsed = ?, status = ? WHERE id = ?",
//         [_elapsedTimes[taskId], _activeTasks[taskId]!.status, taskId],
//       );
//       if (response <= 0) {
//         print('Failed to update database for task $taskId');
//       } else {
//         print(
//             'Database updated for task $taskId: elapsedTime=${_elapsedTimes[taskId]}, status=${_activeTasks[taskId]!.status}');
//       }
//     } catch (e) {
//       print('Error updating database for task $taskId: $e');
//     }
//   }

//   static Future<void> _pauseTask(String taskId) async {
//     try {
//       _timers[taskId]?.cancel();
//       if (_startTimes[taskId] != null) {
//         _elapsedTimes[taskId] = _activeTasks[taskId]!.stopwatchElapsed! +
//             DateTime.now().difference(_startTimes[taskId]!).inSeconds;
//         await _updateDatabase(taskId);
//       }
//       _startTimes[taskId] = null;
//       await _updateNotification(taskId);
//     } catch (e) {
//       print('Error pausing task $taskId: $e');
//     }
//   }

//   static Future<void> _stopTask(String taskId) async {
//     try {
//       _timers[taskId]?.cancel();
//       if (_startTimes[taskId] != null) {
//         _elapsedTimes[taskId] = _activeTasks[taskId]!.stopwatchElapsed! +
//             DateTime.now().difference(_startTimes[taskId]!).inSeconds;
//         await _updateDatabase(taskId);
//       }
//       await clearNotification(taskId);
//       _activeTasks.remove(taskId);
//       _elapsedTimes.remove(taskId);
//       _startTimes.remove(taskId);
//       _timers.remove(taskId);
//     } catch (e) {
//       print('Error stopping task $taskId: $e');
//     }
//   }

//   static Future<void> _stopAllTasks() async {
//     try {
//       for (var taskId in _activeTasks.keys.toList()) {
//         await _stopTask(taskId);
//       }
//       print('All tasks stopped');
//     } catch (e) {
//       print('Error stopping all tasks: $e');
//     }
//   }

//   static Future<void> _updateNotification(String taskId) async {
//     if (!_activeTasks.containsKey(taskId)) {
//       print('No task $taskId to update notification');
//       return;
//     }
//     if (_activeTasks[taskId]!.status != 'In Progress' &&
//         _activeTasks[taskId]!.status != 'Pending') {
//       await clearNotification(taskId);
//       return;
//     }
//     final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     final duration = Duration(seconds: _elapsedTimes[taskId] ?? 0);
//     final hours = duration.inHours;
//     final minutes = duration.inMinutes.remainder(60);
//     final seconds = duration.inSeconds.remainder(60);
//     final timeString =
//         "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";

//     final notificationContent =
//         'Task: ${_activeTasks[taskId]?.title ?? "Unknown"} - Stopwatch: $timeString';
//     if (_lastNotificationContent == notificationContent) {
//       return; // Skip if content hasn't changed
//     }
//     _lastNotificationContent = notificationContent;

//     final androidDetails = AndroidNotificationDetails(
//       'companymanagment_stopwatch',
//       'companymanagment Stopwatch',
//       channelDescription: 'Stopwatch for companymanagment tasks',
//       importance: Importance.max,
//       priority: Priority.high,
//       ongoing: _activeTasks[taskId]?.status == 'In Progress',
//       autoCancel: false,
//       showProgress: true,
//       ticker: 'companymanagment Stopwatch',
//       groupKey: taskId,
//       actions: [
//         AndroidNotificationAction('pending', 'Pending'),
//         AndroidNotificationAction('in_progress', 'In Progress'),
//         AndroidNotificationAction('completed', 'Completed'),
//         AndroidNotificationAction('dismiss', 'Dismiss'),
//       ],
//     );

//     final iosDetails = DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: false,
//       threadIdentifier: 'companymanagment_stopwatch_$taskId',
//     );

//     final notificationDetails = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );

//     try {
//       await flutterLocalNotificationsPlugin.show(
//         taskId.hashCode,
//         'Task: ${_activeTasks[taskId]?.title ?? "Unknown"}',
//         'Stopwatch: $timeString',
//         notificationDetails,
//         payload: taskId,
//       );
//       print('Notification updated for task $taskId: $timeString');
//     } catch (e) {
//       print('Error showing notification for task $taskId: $e');
//     }
//   }
// }
