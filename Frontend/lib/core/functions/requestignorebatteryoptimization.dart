// import 'package:permission_handler/permission_handler.dart';

// Future<void> requestIgnoreBatteryOptimization() async {
//   try {
//     bool granted = await Permission.ignoreBatteryOptimizations.isGranted;
//     if (!granted) {
//       await Permission.ignoreBatteryOptimizations.request();
//     }
//     print('Battery optimization permission: $granted');
//   } catch (e) {
//     print('Error requesting battery optimization: $e');
//   }
// }