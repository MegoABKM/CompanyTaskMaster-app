import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/tasks/viewtask_controller.dart';
import 'package:tasknotate/core/shared/mediaviewer/imageviewerscreen.dart';
import 'package:tasknotate/core/shared/mediaviewer/videoplayerscreen.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';

class AttachmentsSection extends GetView<ViewTaskCompanyManagerController> {
  final ThemeData theme;
  const AttachmentsSection({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "269".tr, // Attachments
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: scaleConfig.scaleText(18),
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            TextButton(
              onPressed: () => controller.goToUpdateFile(),
              child: Text(
                "309".tr, // Edit
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: scaleConfig.scaleText(14),
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: scaleConfig.scale(8)),
        controller.attachments.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.attachments.length,
                itemBuilder: (context, index) {
                  final attachment = controller.attachments[index];
                  return AttachmentCard(
                    controller: controller,
                    attachment: attachment,
                    theme: theme,
                    scaleConfig: scaleConfig,
                  );
                },
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: scaleConfig.scale(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: scaleConfig.scale(20),
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    SizedBox(width: scaleConfig.scale(8)),
                    Text(
                      "326".tr, // No attachments available.
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: scaleConfig.scaleText(12),
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}

class AttachmentCard extends StatelessWidget {
  final ViewTaskCompanyManagerController controller;
  final dynamic attachment;
  final ThemeData theme;
  final ScaleConfig scaleConfig;

  const AttachmentCard({
    super.key,
    required this.controller,
    required this.attachment,
    required this.theme,
    required this.scaleConfig,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: scaleConfig.scale(2),
      margin: EdgeInsets.symmetric(vertical: scaleConfig.scale(8)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(scaleConfig.scale(12)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(scaleConfig.scale(12)),
        leading: _getFileIcon(attachment.filename),
        title: Text(
          attachment.filename ?? "318".tr, // N/A
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: scaleConfig.scaleText(16),
          ),
        ),
        subtitle: Text(
          "300".tr + " ${_formatDate(attachment.uploadedAt)}", // Uploaded:
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: scaleConfig.scaleText(12),
          ),
        ),
        onTap: () {
          if (attachment.filename.endsWith('.jpg') ||
              attachment.filename.endsWith('.png') ||
              attachment.filename.endsWith('.jpeg')) {
            Get.to(() => ImageViewerPage(
                  imageUrl: controller.getCompanyFileUrl(attachment.url),
                ));
          } else if (attachment.filename.endsWith('.mp4')) {
            Get.to(() => VideoPlayerScreen(
                  videoUrl: controller.getCompanyFileUrl(attachment.url),
                ));
          } else {
            controller.openFile(attachment.url);
          }
        },
      ),
    );
  }

  Widget _getFileIcon(String? filename) {
    if (filename == null) {
      return Icon(Icons.insert_drive_file,
          color: Colors.grey, size: scaleConfig.scale(24));
    }
    if (filename.endsWith('.pdf')) {
      return Icon(Icons.picture_as_pdf,
          color: Colors.red, size: scaleConfig.scale(24));
    } else if (filename.endsWith('.mp4')) {
      return Icon(Icons.video_file,
          color: Colors.blue, size: scaleConfig.scale(24));
    } else if (filename.endsWith('.ppt') || filename.endsWith('.pptx')) {
      return Icon(Icons.slideshow,
          color: Colors.orange, size: scaleConfig.scale(24));
    } else if (filename.endsWith('.jpg') ||
        filename.endsWith('.jpeg') ||
        filename.endsWith('.png') ||
        filename.endsWith('.gif') ||
        filename.endsWith('.bmp')) {
      return Icon(Icons.image,
          color: Colors.green, size: scaleConfig.scale(24));
    } else {
      return Icon(Icons.insert_drive_file,
          color: Colors.grey, size: scaleConfig.scale(24));
    }
  }

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return "328".tr; // No date provided
    try {
      final parsedDate = DateTime.parse(date.trim());
      return "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";
    } catch (e) {
      return "329".tr; // Invalid date
    }
  }
}
