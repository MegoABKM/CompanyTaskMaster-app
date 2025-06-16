import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/employee/tasks/viewtaskemp_controller.dart';
import 'package:tasknotate/core/functions/formatdate.dart';
import 'package:tasknotate/core/shared/mediaviewer/imageviewerscreen.dart';
import 'package:tasknotate/core/shared/mediaviewer/videoplayerscreen.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';

class AttachmentsSectionEmp extends GetView<ViewtaskEmpController> {
  final ThemeData theme;

  const AttachmentsSectionEmp({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(scaleConfig.scale(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "269".tr, // Attachments
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: scaleConfig.scaleText(18),
              fontWeight: FontWeight.bold,
              color: Colors.black87, // Match manager's title color
            ),
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
                        color: Colors.black54, // Match manager's no-data color
                      ),
                      SizedBox(width: scaleConfig.scale(8)),
                      Text(
                        "326".tr, // No attachments available.
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: scaleConfig.scaleText(12),
                          color:
                              Colors.black54, // Match manager's no-data color
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class AttachmentCard extends StatelessWidget {
  final ViewtaskEmpController controller;
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
            color: Colors.black87, // Match manager's title color
          ),
        ),
        subtitle: Text(
          "300".tr + " ${formatDate(attachment.uploadedAt)}", // Uploaded:
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: scaleConfig.scaleText(12),
            color: Colors.black54, // Match manager's subtitle color
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
}
