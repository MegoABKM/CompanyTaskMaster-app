import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/filefunctions.dart';
import 'package:companymanagment/core/functions/fileutils.dart';
import 'package:companymanagment/data/datasource/remote/company/filedata.dart';
import 'package:companymanagment/data/model/company/tasks/assignedemployeemodel.dart';
import 'package:companymanagment/data/model/company/tasks/attachmentmodel.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';
import 'package:companymanagment/data/model/company/tasks/subtasksmode.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdatefilefortaskController extends GetxController {
  File? file;
  String fileType = '';
  String? taskId;
  List<SubtaskModel> subtasks = [];
  List<AttachmentModel> attachments = [];
  String? from;
  TaskCompanyModel? taskcompanydetail;
  List<Assignedemployeemodel> assignedemployee = [];
  List<Employees>? companyemployee = [];
  Filedata updatefileData = Filedata(Get.find());
  late TextEditingController fileNameController;
  final ImagePicker picker = ImagePicker();
  StatusRequest? statusRequest;

  @override
  void onInit() {
    super.onInit();
    fileNameController = TextEditingController();
    from = Get.arguments?['from'] ?? '';
    attachments = Get.arguments['attachments'] ?? [];
    subtasks = Get.arguments['subtasks'] ?? [];
    companyemployee = Get.arguments['companyemployee'] ?? [];
    taskcompanydetail = Get.arguments['taskcompanydetail'];
    taskId = Get.arguments?['taskid'];
    if (taskId == null) {
      Get.snackbar("Error", "Task ID is missing.");
    }
    getData(); // Fetch initial attachments
  }

  Future<void> showFilePicker() async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final fileType = determineFileType(pickedFile.path);
        setFile(File(pickedFile.path), fileType, taskId);
        fileNameController.text = pickedFile.name;
        await uploadFile();
      } else {
        Get.snackbar("Info", "No file selected.");
      }
    } catch (error) {
      Get.snackbar("Error", "An error occurred while picking the file: $error");
    } finally {
      statusRequest = null;
      update();
    }
  }

  Future<void> getData() async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      attachments = await FileUtils.fetchAttachments(taskId);
      statusRequest = StatusRequest.success;
      update();
    } catch (e) {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Error", "Failed to fetch attachments: $e");
      update();
    }
  }

  Future<void> uploadFile() async {
    if (file == null || taskId == null) {
      Get.snackbar(
          "Error",
          file == null
              ? "Please select a file to upload."
              : "Task ID is missing.");
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    String filename = fileNameController.text.trim();
    if (filename.isEmpty) {
      filename = 'file_${DateTime.now().millisecondsSinceEpoch}';
      fileNameController.text = filename;
    }

    try {
      await FileUtils.uploadFile(
        file: file!,
        fileType: fileType,
        taskId: taskId!,
        filename: filename,
        onSuccess: (uploadedFilename) async {
          await saveFileToDatabase(uploadedFilename);
          await getData(); // Refresh attachments
          Get.snackbar("Success", "File uploaded successfully.");
        },
        onFailure: (message) {
          Get.snackbar("Error", message);
        },
      );
      statusRequest = StatusRequest.success;
    } catch (e) {
      statusRequest = StatusRequest.failure;
      Get.snackbar("Error", "Failed to upload file: $e");
    } finally {
      update();
    }
  }

  Future<void> saveFileToDatabase(String filename) async {
    try {
      var url = Uri.parse(AppLink.saveattachment);
      var response = await http.post(url, body: {
        'taskid': taskId!,
        'filename': filename,
        'url': 'upload/files/company/$filename',
      });

      if (response.statusCode == 200 &&
          jsonDecode(response.body)['status'] == 'success') {
        print("File saved to database successfully.");
      } else {
        Get.snackbar("Error", "Failed to save file in database.");
      }
    } catch (error) {
      Get.snackbar("Error", "An error occurred while saving the file: $error");
    }
  }

  Future<void> deleteAttachment(AttachmentModel attachment) async {
    statusRequest = StatusRequest.loading;
    update();

    final fileName = attachment.url.split('/').last;
    final url = Uri.parse(AppLink.filedelete);

    try {
      final response =
          await http.post(url, body: {'delete_filename': fileName});
      if (response.statusCode == 200 &&
          jsonDecode(response.body)['status'] == 'success') {
        await deleteFromDataBase(attachment.id.toString());
        Get.snackbar('Success', 'Attachment deleted successfully');
      } else {
        Get.snackbar(
            'Error', jsonDecode(response.body)['message'] ?? 'Deletion failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      statusRequest = null;
      update();
    }
  }

  Future<void> deleteFromDataBase(String? id) async {
    try {
      var response = await updatefileData.removedata(id);
      if (response['status'] == "success") {
        updateAttachmentsList(id);
      } else {
        Get.snackbar("Error", "Failed to delete: ${response['message']}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  void updateAttachmentsList(String? id) {
    attachments.removeWhere((attachment) => attachment.id.toString() == id);
    update();
  }

  String getCompanyFileUrl(String fileurl) {
    return '${AppLink.server}/$fileurl';
  }

  void setFile(File selectedFile, String type, String? taskId) {
    file = selectedFile;
    fileType = type;
    this.taskId = taskId;
    update();
  }

  Future<void> openFile(String fileName) async {
    final String fileUrl = getCompanyFileUrl(fileName);
    try {
      final Uri uri = Uri.parse(fileUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $fileUrl';
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to open file: $e");
    }
  }

  void goToViewDetails() {
    //  Get.offAll(const HomeNavigator(), arguments: {});
  }

  Future<void> updateFilename(String id, String newFilename) async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await updatefileData.updateData(id, newFilename);
      if (response["status"] == "success") {
        final index = attachments.indexWhere((a) => a.id.toString() == id);
        if (index != -1) {
          attachments[index] = AttachmentModel(
            id: attachments[index].id,
            filename: newFilename,
            url: attachments[index].url,
            uploadedAt: attachments[index].uploadedAt,
          );
          update();
          Get.snackbar("Success", "Filename updated successfully.");
        } else {
          Get.snackbar("Error", "Attachment not found in the local list.");
        }
      } else {
        Get.snackbar(
            "Error", "Failed to update filename: ${response['message']}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      statusRequest = null;
      update();
    }
  }

  @override
  void onClose() {
    fileNameController.dispose();
    super.onClose();
  }
}
