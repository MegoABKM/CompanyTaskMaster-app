import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/tasks/viewtask_controller.dart';
import 'package:companymanagment/core/shared/mediaviewer/imageviewerscreen.dart';
import 'package:companymanagment/core/shared/mediaviewer/videoplayerscreen.dart';
import 'package:companymanagment/core/constant/utils/scale_confige.dart';
import 'package:companymanagment/core/functions/formatdate.dart';

class AttachmentsSection extends GetView<ViewTaskCompanyManagerController> {
  final ThemeData theme;
  const AttachmentsSection({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "269".tr, // Attachments
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: scaleConfig.scaleText(18),
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
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
                      scaleConfig: scaleConfig);
                },
              )
            : Padding(
                padding: EdgeInsets.symmetric(vertical: scaleConfig.scale(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline,
                        size: scaleConfig.scale(20),
                        color: theme.colorScheme.onSurface.withOpacity(0.6)),
                    SizedBox(width: scaleConfig.scale(8)),
                    Text("326".tr,
                        style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: scaleConfig.scaleText(12),
                            color:
                                theme.colorScheme.onSurface.withOpacity(0.6))),
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

  const AttachmentCard(
      {super.key,
      required this.controller,
      required this.attachment,
      required this.theme,
      required this.scaleConfig});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: scaleConfig.scale(2),
      margin: EdgeInsets.symmetric(vertical: scaleConfig.scale(8)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(scaleConfig.scale(12))),
      child: ListTile(
        contentPadding: EdgeInsets.all(scaleConfig.scale(12)),
        leading: _getFileIcon(attachment.filename, scaleConfig),
        title: Text(attachment.filename ?? "318".tr,
            style: theme.textTheme.bodyLarge
                ?.copyWith(fontSize: scaleConfig.scaleText(16))),
        subtitle: Text("300".tr + " ${formatDate(attachment.uploadedAt)}",
            style: theme.textTheme.bodySmall
                ?.copyWith(fontSize: scaleConfig.scaleText(12))),
        onTap: () {
          if (controller.isImage(attachment.filename)) {
            Get.to(() => ImageViewerPage(
                imageUrl: controller.getCompanyFileUrl(attachment.url)));
          } else if (controller.isVideo(attachment.filename)) {
            Get.to(() => VideoPlayerScreen(
                videoUrl: controller.getCompanyFileUrl(attachment.url)));
          } else {
            controller.openFile(attachment.url);
          }
        },
      ),
    );
  }

  Widget _getFileIcon(String? filename, ScaleConfig scaleConfig) {
    if (filename == null)
      return Icon(Icons.insert_drive_file,
          color: Colors.grey, size: scaleConfig.scale(24));
    if (controller.isImage(filename))
      return Icon(Icons.image,
          color: Colors.green, size: scaleConfig.scale(24));
    if (controller.isVideo(filename))
      return Icon(Icons.video_file,
          color: Colors.blue, size: scaleConfig.scale(24));
    if (filename.endsWith('.pdf'))
      return Icon(Icons.picture_as_pdf,
          color: Colors.red, size: scaleConfig.scale(24));
    if (filename.endsWith('.ppt') || filename.endsWith('.pptx'))
      return Icon(Icons.slideshow,
          color: Colors.orange, size: scaleConfig.scale(24));
    return Icon(Icons.insert_drive_file,
        color: Colors.grey, size: scaleConfig.scale(24));
  }
}
