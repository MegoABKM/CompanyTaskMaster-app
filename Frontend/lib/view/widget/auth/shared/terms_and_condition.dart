import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';
import 'package:url_launcher/url_launcher.dart';

class Termsandcondition extends StatelessWidget {
  Termsandcondition({super.key});

  @override
  Widget build(BuildContext context) {
    final ScaleConfig scaleConfig = ScaleConfig(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    Future<void> _launchUrl(String url) async {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $url';
      }
    }

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: textTheme.bodyLarge?.copyWith(
          fontSize: scaleConfig.scaleText(14),
          color: theme.colorScheme.onSurface.withOpacity(0.7),
        ),
        children: [
          TextSpan(
            text: "352".tr,
          ),
          TextSpan(
            text: "353".tr,
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _launchUrl(
                    "https://doc-hosting.flycricket.io/tasknotate-terms-of-use/7dbbcb71-3adb-45c9-b519-740e552f49ba/terms");
              },
          ),
          TextSpan(
            text: "354".tr,
          ),
          TextSpan(
            text: "355".tr,
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _launchUrl(
                    "https://doc-hosting.flycricket.io/tasknotate-privacy-policy/2ad4ba24-c15d-40d0-9b73-83b603ffa073/privacy");
              },
          ),
        ],
      ),
    );
  }
}
