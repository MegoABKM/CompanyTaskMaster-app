import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:tasknotate/core/constant/routes.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/functions/filefunctions.dart';
import 'package:tasknotate/core/functions/fileutils.dart';
import 'package:tasknotate/data/datasource/remote/company/filedata.dart';
import 'package:tasknotate/data/model/company/tasks/attachmentmodel.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';
import 'package:url_launcher/url_launcher.dart';

class AddFileController extends GetxController {
  File? file;
  String fileType = '';
  String? taskId;
  List<AttachmentModel> attachments = [];
  StatusRequest? statusRequest; // Add statusRequest variable

  final ImagePicker picker = ImagePicker();
  Filedata filedata = Filedata(Get.find());
  late TextEditingController fileNameController;

  @override
  void onInit() {
    super.onInit();
    fileNameController = TextEditingController();
    taskId = Get.arguments?['taskid'];
    if (taskId == null) {
      _showSnackbar("Error", "Task ID not provided.");
    }
    fetchAttachments(); // Load existing attachments on init
  }

  void updateAttachmentsList(String? id) {
    attachments.removeWhere((attachment) => attachment.id.toString() == id);
    update();
  }

  Future<void> deleteFromDataBase(String? id) async {
    statusRequest = StatusRequest.loading; // Set loading state
    update();
    try {
      var response = await filedata.removedata(id);
      if (response['status'] == "success") {
        print("Success Delete from Database");
        updateAttachmentsList(id);
        _showSnackbar("Success", "File deleted from database.");
      } else {
        print("Failed to delete: ${response['message']}");
        _showSnackbar("Error", "Failed to delete: ${response['message']}");
      }
    } catch (e) {
      print("Error during deletion: $e");
      _showSnackbar("Error", "An error occurred: $e");
    } finally {
      statusRequest = null; // Reset status after completion
      update();
    }
  }

  Future<void> deleteAttachment(AttachmentModel attachment) async {
    statusRequest = StatusRequest.loading; // Set loading state
    update();
    final fileName = attachment.url.split('/').last;
    final url = Uri.parse(AppLink.filedelete);

    try {
      final response =
          await http.post(url, body: {'delete_filename': fileName});
      if (response.statusCode == 200 &&
          jsonDecode(response.body)['status'] == 'success') {
        await deleteFromDataBase(attachment.id.toString());
      } else {
        _showSnackbar(
            'Error', jsonDecode(response.body)['message'] ?? 'Deletion failed');
      }
    } catch (e) {
      _showSnackbar('Error', 'An error occurred: $e');
      print(e);
    } finally {
      statusRequest = null; // Reset status after completion
      update();
    }
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
      print('Error opening file: $e');
      _showSnackbar("Error", "Failed to open file: $e");
    }
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

  Future<void> showFilePicker() async {
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final fileType = determineFileType(pickedFile.path);
        setFile(File(pickedFile.path), fileType, taskId);
        fileNameController.text = pickedFile.name;
        await uploadFile();
      } else {
        _showSnackbar("Info", "No file selected.");
      }
    } catch (e) {
      _showSnackbar("Error", "An error occurred while picking the file: $e");
    }
  }

  Future<void> pickFile() async {
    final pickedFile = await FileUtils.pickFile();
    if (pickedFile != null) {
      file = pickedFile;
      fileType = FileUtils.determineFileType(pickedFile.path);
      fileNameController.text = pickedFile.path.split('/').last;
      update();
    } else {
      _showSnackbar("Info", "No file selected.");
    }
  }

  Future<void> uploadFile() async {
    if (FileUtils.validateInputs(file, taskId, fileNameController)) return;

    statusRequest = StatusRequest.loading; // Set loading state
    update();
    FileUtils.uploadFile(
      file: file!,
      fileType: fileType,
      taskId: taskId!,
      filename: fileNameController.text,
      onSuccess: (filename) async {
        await _saveFileToDatabase(filename);
        await fetchAttachments(); // Refresh attachments list
        _showSnackbar("Success", "File uploaded successfully.");
      },
      onFailure: (message) {
        _showSnackbar("Error", message);
      },
    ).whenComplete(() {
      statusRequest = null; // Reset status after completion
      update();
    });
  }

  Future<void> fetchAttachments() async {
    statusRequest = StatusRequest.loading; // Set loading state
    update();
    try {
      final fetchedAttachments = await FileUtils.fetchAttachments(taskId);
      attachments = fetchedAttachments;
      update();
    } catch (e) {
      _showSnackbar("Error", "Failed to fetch attachments: $e");
    } finally {
      statusRequest = null; // Reset status after completion
      update();
    }
  }

  Future<void> updateFilename(String id, String newFilename) async {
    statusRequest = StatusRequest.loading; // Set loading state
    update();
    try {
      var response = await filedata.updateData(id, newFilename);
      if (response['status'] == "success") {
        final index = attachments.indexWhere((a) => a.id.toString() == id);
        if (index != -1) {
          attachments[index] = AttachmentModel(
            id: attachments[index].id,
            filename: newFilename,
            url: attachments[index].url,
            uploadedAt: attachments[index].uploadedAt,
          );
          update();
          _showSnackbar("Success", "Filename updated successfully.");
        } else {
          _showSnackbar("Error", "Attachment not found in local list.");
        }
      } else {
        _showSnackbar(
            "Error", "Failed to update filename: ${response['message']}");
      }
    } catch (e) {
      print("Error updating filename: $e");
      _showSnackbar("Error", "An error occurred: $e");
    } finally {
      statusRequest = null; // Reset status after completion
      update();
    }
  }

  Future<void> _saveFileToDatabase(String serverFilename) async {
    final fileExtension = serverFilename.split('.').last;
    final userFilenameWithExt = '${fileNameController.text}.$fileExtension';

    try {
      final response = await http.post(
        Uri.parse(AppLink.saveattachment),
        body: {
          'taskid': taskId!,
          'filename': userFilenameWithExt,
          'url': 'upload/files/company/$serverFilename',
        },
      );

      if (response.statusCode == 200 &&
          jsonDecode(response.body)['status'] == 'success') {
        print("File saved to database: $userFilenameWithExt");
      } else {
        _showSnackbar("Error", "Failed to save file in database.");
      }
    } catch (e) {
      _showSnackbar("Error", "An error occurred while saving the file: $e");
    }
  }

  void skipToWorkspace() {
    Get.offAllNamed(AppRoute.home);
    if (attachments.isEmpty) {
      _showSnackbar("Info", "No files uploaded, returning to workspace.");
    } else {
      _showSnackbar("Success", "Task creation completed.");
    }
  }

  void _showSnackbar(String title, String message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onClose() {
    fileNameController.dispose();
    super.onClose();
  }
}
