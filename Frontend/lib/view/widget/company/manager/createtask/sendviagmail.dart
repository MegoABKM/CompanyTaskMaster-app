// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:companymanagment/controller/company/manager/tasks/createtask/createtask_controller.dart';
// import 'package:companymanagment/core/constant/utils/scale_confige.dart'; // Added for scaleConfig

// class SendViaGmailSwitch extends GetView<CreatetaskController> {
//   const SendViaGmailSwitch({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final scaleConfig = ScaleConfig(context);
//     return SwitchListTile(
//       title: Text(
//         "337".tr, // Send via Gmail
//         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//               fontSize: scaleConfig.scaleText(16),
//             ),
//       ),
//       value: controller.sendViaGmail,
//       activeColor: Theme.of(context).colorScheme.primary,
//       onChanged: controller.updateSendViaGmail,
//       contentPadding: EdgeInsets.symmetric(horizontal: scaleConfig.scale(0)),
//     );
//   }
// }
