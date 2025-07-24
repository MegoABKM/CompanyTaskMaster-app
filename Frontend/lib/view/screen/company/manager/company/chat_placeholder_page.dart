import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';

class ChatPlaceholderPage extends StatelessWidget {
  const ChatPlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Employees employee = Get.arguments['employee'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Message ${employee.employeeName ?? ''}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.chat_bubble_outline, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              "Chat Feature Coming Soon",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              "Direct messaging will be available in a future update.",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
