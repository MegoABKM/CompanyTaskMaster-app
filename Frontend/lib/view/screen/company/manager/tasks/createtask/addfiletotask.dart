import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/tasks/createtask/createfilefortask.dart';
import 'package:tasknotate/core/class/handlingdataview.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/constant/utils/scale_confige.dart';
import 'package:tasknotate/data/model/company/tasks/attachmentmodel.dart';
import 'package:tasknotate/core/shared/mediaviewer/imageviewerscreen.dart';
import 'package:tasknotate/core/shared/mediaviewer/videoplayerscreen.dart';

class AddFilePage extends StatelessWidget {
  AddFilePage({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final scaleConfig = ScaleConfig(context);
    final theme = Theme.of(context);

    return GetBuilder<AddFileController>(
      init: AddFileController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '289'.tr, // Upload File
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: scaleConfig.scaleText(20),
                color: Colors.white,
              ),
            ),
            backgroundColor: theme.colorScheme.primary,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.add, size: scaleConfig.scale(24)),
                onPressed: controller.showFilePicker,
              ),
            ],
          ),
          body: Handlingdataview(
            statusRequest: controller.statusRequest,
            widget: Padding(
              padding: EdgeInsets.all(scaleConfig.scale(16)),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (controller.attachments.isEmpty)
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: scaleConfig.scale(40)),
                              Icon(
                                Icons.upload_file,
                                size: scaleConfig.scale(80),
                                color:
                                    theme.colorScheme.primary.withOpacity(0.7),
                              ),
                              SizedBox(height: scaleConfig.scale(16)),
                              Text(
                                "290".tr, // No files uploaded yet.
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontSize: scaleConfig.scaleText(18),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: scaleConfig.scale(20)),
                              ElevatedButton(
                                onPressed: controller.skipToWorkspace,
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: scaleConfig.scale(20),
                                    vertical: scaleConfig.scale(12),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        scaleConfig.scale(12)),
                                  ),
                                ),
                                child: Text(
                                  "291".tr, // Skip to Workspace
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: scaleConfig.scaleText(16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      else ...[
                        TextFormField(
                          controller: controller.fileNameController,
                          decoration: InputDecoration(
                            labelText: '292'.tr, // Enter File Name
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(scaleConfig.scale(8)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: scaleConfig.scale(12),
                              vertical: scaleConfig.scale(10),
                            ),
                            filled: true,
                            fillColor:
                                theme.colorScheme.surfaceContainerHighest,
                          ),
                          style: TextStyle(fontSize: scaleConfig.scaleText(16)),
                          validator: (value) =>
                              value == null || value.isEmpty ? '304'.tr : null,
                        ),
                        SizedBox(height: scaleConfig.scale(20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                              onPressed: controller.statusRequest !=
                                      StatusRequest.loading
                                  ? controller.pickFile
                                  : null,
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: scaleConfig.scale(20),
                                  vertical: scaleConfig.scale(12),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      scaleConfig.scale(12)),
                                ),
                              ),
                              child: controller.statusRequest ==
                                      StatusRequest.loading
                                  ? SizedBox(
                                      width: scaleConfig.scale(24),
                                      height: scaleConfig.scale(24),
                                      child: CircularProgressIndicator(
                                        strokeWidth: scaleConfig.scale(2),
                                      ),
                                    )
                                  : Text(
                                      "293".tr, // Pick File
                                      style:
                                          theme.textTheme.bodyLarge?.copyWith(
                                        fontSize: scaleConfig.scaleText(16),
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                            ),
                            ElevatedButton(
                              onPressed: controller.statusRequest !=
                                      StatusRequest.loading
                                  ? () {
                                      if (formKey.currentState!.validate()) {
                                        if (controller.file != null) {
                                          controller.uploadFile();
                                        } else {
                                          Get.snackbar(
                                            "Error",
                                            "Please pick a file before uploading.",
                                          );
                                        }
                                      }
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal: scaleConfig.scale(20),
                                  vertical: scaleConfig.scale(12),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      scaleConfig.scale(12)),
                                ),
                              ),
                              child: controller.statusRequest ==
                                      StatusRequest.loading
                                  ? SizedBox(
                                      width: scaleConfig.scale(24),
                                      height: scaleConfig.scale(24),
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: scaleConfig.scale(2),
                                      ),
                                    )
                                  : Text(
                                      "294".tr, // Upload File
                                      style:
                                          theme.textTheme.bodyLarge?.copyWith(
                                        fontSize: scaleConfig.scaleText(16),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(height: scaleConfig.scale(20)),
                        controller.file != null
                            ? Text(
                                '295'.tr +
                                    ' ${controller.file!.path}', // Selected File:
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: scaleConfig.scaleText(14),
                                ),
                              )
                            : Text(
                                '296'.tr, // No file selected
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: scaleConfig.scaleText(14),
                                  color: Colors.grey,
                                ),
                              ),
                        SizedBox(height: scaleConfig.scale(10)),
                        controller.fileNameController.text.isNotEmpty
                            ? Text(
                                '297'.tr +
                                    ' ${controller.fileNameController.text}', // File Name:
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: scaleConfig.scaleText(14),
                                ),
                              )
                            : Text(
                                '298'.tr, // No file name entered
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: scaleConfig.scaleText(14),
                                  color: Colors.grey,
                                ),
                              ),
                        Divider(
                          height: scaleConfig.scale(30),
                          thickness: scaleConfig.scale(1),
                          color: theme.dividerColor,
                        ),
                        Text(
                          '299'.tr, // Uploaded Attachments:
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: scaleConfig.scaleText(16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: scaleConfig.scale(10)),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.attachments.length,
                          itemBuilder: (context, index) {
                            final attachment = controller.attachments[index];
                            return Card(
                              elevation: scaleConfig.scale(2),
                              margin: EdgeInsets.symmetric(
                                vertical: scaleConfig.scale(8),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    scaleConfig.scale(12)),
                              ),
                              child: ListTile(
                                leading: _getFileIcon(
                                    attachment.filename, scaleConfig),
                                title: Text(
                                  attachment.filename,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontSize: scaleConfig.scaleText(16),
                                  ),
                                ),
                                subtitle: Text(
                                  '300'.tr +
                                      ' ${_formatDate(attachment.uploadedAt)}', // Uploaded:
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontSize: scaleConfig.scaleText(12),
                                    color: Colors.grey,
                                  ),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        size: scaleConfig.scale(24),
                                        color: theme.colorScheme.primary,
                                      ),
                                      onPressed: () => _showEditDialog(
                                          context,
                                          attachment,
                                          controller,
                                          scaleConfig,
                                          theme),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        size: scaleConfig.scale(24),
                                        color: Colors.red,
                                      ),
                                      onPressed: () => controller
                                          .deleteAttachment(attachment),
                                    ),
                                  ],
                                ),
                                onTap: () => _openAttachment(
                                    context, attachment, controller),
                              ),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _getFileIcon(String filename, ScaleConfig scaleConfig) {
    if (filename.endsWith('.jpg') ||
        filename.endsWith('.png') ||
        filename.endsWith('.jpeg')) {
      return Icon(Icons.image, color: Colors.blue, size: scaleConfig.scale(24));
    } else if (filename.endsWith('.mp4')) {
      return Icon(Icons.video_call,
          color: Colors.blue, size: scaleConfig.scale(24));
    } else if (filename.endsWith('.pdf')) {
      return Icon(Icons.picture_as_pdf,
          color: Colors.red, size: scaleConfig.scale(24));
    } else if (filename.endsWith('.docx') || filename.endsWith('.doc')) {
      return Icon(Icons.article,
          color: Colors.green, size: scaleConfig.scale(24));
    } else {
      return Icon(Icons.attach_file,
          color: Colors.grey, size: scaleConfig.scale(24));
    }
  }

  String _formatDate(String? date) {
    if (date == null) return "N/A";
    final parsedDate = DateTime.tryParse(date);
    return parsedDate != null
        ? "${parsedDate.day}-${parsedDate.month}-${parsedDate.year} ${parsedDate.hour}:${parsedDate.minute}"
        : "N/A";
  }

  void _openAttachment(BuildContext context, AttachmentModel attachment,
      AddFileController controller) {
    if (attachment.filename.endsWith('.jpg') ||
        attachment.filename.endsWith('.png') ||
        attachment.filename.endsWith('.jpeg')) {
      Get.to(() => ImageViewerPage(
          imageUrl: controller.getCompanyFileUrl(attachment.url)));
    } else if (attachment.filename.endsWith('.mp4')) {
      Get.to(() => VideoPlayerScreen(
          videoUrl: controller.getCompanyFileUrl(attachment.url)));
    } else {
      controller.openFile(attachment.url);
    }
  }

  void _showEditDialog(BuildContext context, AttachmentModel attachment,
      AddFileController controller, ScaleConfig scaleConfig, theme) {
    final String filename = attachment.filename;
    final String baseName = filename.substring(0, filename.lastIndexOf('.'));
    final String extension = filename.substring(filename.lastIndexOf('.'));
    controller.fileNameController.text = baseName;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(scaleConfig.scale(12)),
        ),
        title: Text(
          '301'.tr, // Edit Attachment Name
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: scaleConfig.scaleText(18),
          ),
        ),
        content: TextFormField(
          controller: controller.fileNameController,
          decoration: InputDecoration(
            labelText: '302'.tr, // Filename
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(scaleConfig.scale(8)),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: scaleConfig.scale(12),
              vertical: scaleConfig.scale(10),
            ),
            filled: true,
            fillColor: theme.colorScheme.surfaceVariant,
          ),
          style: TextStyle(fontSize: scaleConfig.scaleText(16)),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              '303'.tr, // Cancel
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: scaleConfig.scaleText(14),
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final newBaseName = controller.fileNameController.text.trim();
              if (newBaseName.isNotEmpty) {
                final newFilename = '$newBaseName$extension';
                controller.updateFilename(
                    attachment.id.toString(), newFilename);
                Get.back();
              } else {
                Get.snackbar("Error", "Filename cannot be empty.");
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: scaleConfig.scale(16),
                vertical: scaleConfig.scale(8),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(scaleConfig.scale(8)),
              ),
            ),
            child: Text(
              '278'.tr, // Save
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: scaleConfig.scaleText(14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
