// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:tasknotate/core/services/background_service.dart';

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> initialize() async {
//     const AndroidNotificationChannel channel = AndroidNotificationChannel(
//       'tasknotate_stopwatch',
//       'Tasknotate Stopwatch',
//       description: 'Stopwatch for Tasknotate tasks',
//       importance: Importance.high,
//       playSound: false,
//       enableVibration: false,
//       showBadge: true,
//     );

//     const AndroidInitializationSettings androidInit =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     const DarwinInitializationSettings iosInit = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: false,
//     );
//     const InitializationSettings initSettings =
//         InitializationSettings(android: androidInit, iOS: iosInit);

//     try {
//       // Request notification permission for Android 13+
//       final androidPlugin =
//           _notificationsPlugin.resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>();
//       if (androidPlugin != null) {
//         bool? granted = await androidPlugin.requestNotificationsPermission();
//         print('Notification permission granted: $granted');
//         if (granted == false) {
//           await Permission.notification.request();
//           print('Requested notification permission via permission_handler');
//         }
//         await androidPlugin.createNotificationChannel(channel);
//         print('Notification channel created: tasknotate_stopwatch');
//       }

//       bool? initialized = await _notificationsPlugin.initialize(
//         initSettings,
//         onDidReceiveNotificationResponse: (response) async {
//           print(
//               'Notification action received: ${response.actionId}, payload: ${response.payload}');
//           await _handleNotificationAction(response.actionId, response.payload);
//         },
//         onDidReceiveBackgroundNotificationResponse: _handleBackgroundAction,
//       );
//       if (initialized == true) {
//         print('NotificationService initialized successfully');
//       } else {
//         print('NotificationService initialization failed');
//       }
//     } catch (e) {
//       print('Error initializing NotificationService: $e');
//     }
//   }

//   static Future<void> _handleNotificationAction(
//       String? actionId, String? payload) async {
//     try {
//       print('Handling action: $actionId, payload: $payload');
//       if (actionId == null || payload == null) {
//         print('Invalid actionId or payload');
//         return;
//       }

//       switch (actionId.toLowerCase()) {
//         case 'pending':
//           await BackgroundService.updateStatus('Pending', payload);
//           break;
//         case 'in_progress':
//           await BackgroundService.updateStatus('In Progress', payload);
//           break;
//         case 'completed':
//           await BackgroundService.updateStatus('Completed', payload);
//           await BackgroundService.stopService(payload);
//           break;
//         case 'dismiss':
//           await BackgroundService.clearNotification(payload);
//           break;
//         default:
//           print('Unknown action: $actionId');
//       }
//     } catch (e) {
//       print('Error handling notification action: $e');
//     }
//   }

//   static void _handleBackgroundAction(NotificationResponse response) {
//     print(
//         'Background action received: ${response.actionId}, payload: ${response.payload}');
//     _handleNotificationAction(response.actionId, response.payload);
//   }
// }
