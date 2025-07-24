import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/constant/utils/extensions.dart';

class Messagemanagerandemployee extends StatelessWidget {
  const Messagemanagerandemployee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '261'.tr, // Chat Feature
          style: TextStyle(
            fontSize: context.scaleConfig.scaleText(20),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: context.appTheme.colorScheme.primary,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.appTheme.colorScheme.primary,
              context.appTheme.colorScheme.secondary.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: context.scaleConfig.scale(120),
              color: Colors.white.withOpacity(0.9),
            ),
            SizedBox(height: context.scaleConfig.scale(20)),
            Text(
              '262'.tr, // Chat Feature Coming Soon!
              style: context.appTheme.textTheme.headlineMedium?.copyWith(
                fontSize: context.scaleConfig.scaleText(28),
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black26,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.scaleConfig.scale(15)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.scaleConfig.scale(20)),
              child: Text(
                '263'
                    .tr, // We are working hard to bring the chat feature. Stay tuned!
                style: context.appTheme.textTheme.bodyLarge?.copyWith(
                  fontSize: context.scaleConfig.scaleText(16),
                  color: Colors.white70,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
