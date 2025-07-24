import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/filefunctions.dart';
import 'package:companymanagment/core/functions/fileutils.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/data/datasource/remote/company/filedata.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/assigneemployeetotask.dart';
import 'package:companymanagment/data/datasource/remote/company/taskcompany_data.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';
import 'package:companymanagment/data/model/company/tasks/assignedemployeemodel.dart';
import 'package:companymanagment/data/model/company/tasks/attachmentmodel.dart';
import 'package:companymanagment/data/model/company/tasks/subtasksmode.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';

class UpdatetaskCompanyController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Dependencies
  final Taskcompanydata taskData = Taskcompanydata(Get.find());
  final AssigneemployeetotaskData assignData =
      AssigneemployeetotaskData(Get.find());
  final Filedata fileData = Filedata(Get.find());
  final ImagePicker picker = ImagePicker();
  late TextEditingController startDateController;
  // Main Task Data
  late TaskCompanyModel taskcompanydetail;
  late List<Employees> companyemployee;

  // UI State & Controllers
  late TabController tabController;
  StatusRequest? statusRequest;

  // Tab 1: Details
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController dueDateController;
  String priority = 'Medium';
  String status = 'Pending';
  List<String> priorityOptions = ["Low", "Medium", "High", "Critical"];
  List<String> statusOptions = ["Pending", "In Progress", "Completed"];

  // Tab 2: Assignments
  List<Employees> assignedEmployees = [];

  // Tab 3: Subtasks
  List<SubtaskModel> subtasks = [];
  List<TextEditingController> subtaskTitleControllers = [];
  List<TextEditingController> subtaskDescControllers = [];

  // Tab 4: Attachments
  List<AttachmentModel> attachments = [];
  File? fileToUpload;
  String? fileToUploadType;
  TextEditingController fileNameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Initialize data from arguments passed by ViewTaskCompany screen
    taskcompanydetail = Get.arguments['taskcompanydetail'];
    companyemployee = Get.arguments['companyemployee'] ?? [];
    List<Assignedemployeemodel> initialAssigned =
        Get.arguments['assignedemployee'] ?? [];
    assignedEmployees = companyemployee
        .where((emp) => initialAssigned.any((a) => a.userId == emp.employeeId))
        .toList();

    subtasks = List<SubtaskModel>.from(Get.arguments['subtasks'] ?? []);
    attachments =
        List<AttachmentModel>.from(Get.arguments['attachments'] ?? []);

    // Initialize form controllers
    titleController = TextEditingController(text: taskcompanydetail.title);
    descriptionController =
        TextEditingController(text: taskcompanydetail.description);
    dueDateController = TextEditingController(text: taskcompanydetail.dueDate);
    priority = taskcompanydetail.priority ?? 'Medium';
    status = taskcompanydetail.status ?? 'Pending';
    startDateController = TextEditingController(
        text: taskcompanydetail.startDate); // <-- ADD THIS
    _initializeSubtaskControllers();

    tabController = TabController(length: 4, vsync: this);
  }

  void _initializeSubtaskControllers() {
    for (var controller in subtaskTitleControllers) {
      controller.dispose();
    }
    for (var controller in subtaskDescControllers) {
      controller.dispose();
    }
    subtaskTitleControllers.clear();
    subtaskDescControllers.clear();
    for (var subtask in subtasks) {
      subtaskTitleControllers.add(TextEditingController(text: subtask.title));
      subtaskDescControllers
          .add(TextEditingController(text: subtask.description));
    }
  }

  void finishEditing() {
    Get.back(result: 'updated');
  }

  void updatePriority(String? newPriority) {
    if (newPriority != null) priority = newPriority;
    update(['details']);
  }

  void updateStatus(String? newStatus) {
    if (newStatus != null) status = newStatus;
    update(['details']);
  }

  Future<void> saveDetailsChanges() async {
    statusRequest = StatusRequest.loading;
    update(['details']);
    var response = await taskData.updateData(
      taskid: taskcompanydetail.id,
      tasktitle: titleController.text,
      taskdescription: descriptionController.text,
      taskstartdate: startDateController.text, // <-- ADD THIS
      taskduedate: dueDateController.text,
      taskpriority: priority,
      taskstatus: status,
      tasklastupdate: DateTime.now().toIso8601String(),
      companyid: taskcompanydetail.companyId,
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success &&
        response['status'] == 'success') {
      Get.snackbar("Success", "details_updated_success".tr);
      taskcompanydetail.title = titleController.text;
      taskcompanydetail.startDate = startDateController.text;
      taskcompanydetail.description = descriptionController.text;
      taskcompanydetail.dueDate = dueDateController.text;
      taskcompanydetail.priority = priority;
      taskcompanydetail.status = status;
    } else {
      Get.snackbar("Error", "details_updated_error".tr);
      statusRequest = StatusRequest.failure;
    }
    update(['details']);
  }

  void toggleEmployeeAssignment(Employees employee) {
    final isAssigned =
        assignedEmployees.any((e) => e.employeeId == employee.employeeId);
    if (isAssigned) {
      assignedEmployees.removeWhere((e) => e.employeeId == employee.employeeId);
    } else {
      assignedEmployees.add(employee);
    }
    update(['assignments']);
  }

  Future<void> saveAssignmentChanges() async {
    String userIds = assignedEmployees.map((e) => e.employeeId!).join(',');
    statusRequest = StatusRequest.loading;
    update(['assignments']);
    var response = await assignData.updateData(taskcompanydetail.id, userIds);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success &&
        response['status'] == 'success') {
      Get.snackbar("Success", "assignments_updated_success".tr);
    } else {
      Get.snackbar("Error", "assignments_updated_error".tr);
      statusRequest = StatusRequest.failure;
    }
    update(['assignments']);
  }

  void addSubtask() {
    subtasks.add(SubtaskModel(
        id: -(DateTime.now().millisecondsSinceEpoch),
        title: '',
        description: ''));
    subtaskTitleControllers.add(TextEditingController());
    subtaskDescControllers.add(TextEditingController());
    update(['subtasks']);
  }

  void removeSubtask(int index) {
    subtasks.removeAt(index);
    subtaskTitleControllers.removeAt(index).dispose();
    subtaskDescControllers.removeAt(index).dispose();
    update(['subtasks']);
  }

  Future<void> saveSubtaskChanges() async {
    statusRequest = StatusRequest.loading;
    update(['subtasks']);

    List<Map<String, dynamic>> subtaskData = [];
    for (int i = 0; i < subtasks.length; i++) {
      subtaskData.add({
        "id": subtasks[i].id,
        "title": subtaskTitleControllers[i].text,
        "description": subtaskDescControllers[i].text,
      });
    }

    final response = await http.post(
      Uri.parse(AppLink.updatesubtask),
      headers: {"Content-Type": "application/json"},
      body:
          jsonEncode({"taskid": taskcompanydetail.id, "subtasks": subtaskData}),
    );

    statusRequest = null;
    if (response.statusCode == 200 &&
        jsonDecode(response.body)['status'] == 'success') {
      Get.snackbar("Success", "subtasks_saved_success".tr);
    } else {
      Get.snackbar("Error", "subtasks_saved_error".tr);
    }
    update(['subtasks']);
  }

  Future<void> pickAndUploadFile() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    statusRequest = StatusRequest.loading;
    update(['attachments']);

    fileNameController.text = pickedFile.name.split('.').first;

    await FileUtils.uploadFile(
      file: File(pickedFile.path),
      fileType: determineFileType(pickedFile.path),
      taskId: taskcompanydetail.id,
      filename: fileNameController.text,
      onSuccess: (filename) async {
        await _saveFileToDatabase(filename);
        await refreshAttachments();
        Get.snackbar("Success", 'attachment_upload_success'.tr);
      },
      onFailure: (message) {
        Get.snackbar("Error", '${'attachment_upload_error'.tr}: $message');
        statusRequest = StatusRequest.failure;
        update(['attachments']);
      },
    );
  }

  Future<void> _saveFileToDatabase(String serverFilename) async {
    final fileExtension = serverFilename.split('.').last;
    final userFilenameWithExt = '${fileNameController.text}.$fileExtension';
    await http.post(
      Uri.parse(AppLink.saveattachment),
      body: {
        'taskid': taskcompanydetail.id!,
        'filename': userFilenameWithExt,
        'url': 'upload/files/company/$serverFilename'
      },
    );
  }

  Future<void> refreshAttachments() async {
    var response = await fileData.getData(taskcompanydetail.id);
    if (response['status'] == 'success') {
      attachments = (response['data'] as List? ?? [])
          .map((e) => AttachmentModel.fromJson(e))
          .toList();
    } else {
      Get.snackbar("Error", 'attachments_refreshed_error'.tr);
    }
    statusRequest = null;
    update(['attachments']);
  }

  Future<void> deleteAttachment(AttachmentModel attachment) async {
    statusRequest = StatusRequest.loading;
    update(['attachments']);

    final fileName = attachment.url.split('/').last;
    final url = Uri.parse(AppLink.filedelete);
    try {
      final response =
          await http.post(url, body: {'delete_filename': fileName});
      if (response.statusCode == 200 &&
          jsonDecode(response.body)['status'] == 'success') {
        await fileData.removedata(attachment.id.toString());
        await refreshAttachments();
        Get.snackbar('Success', 'attachment_deleted_success'.tr);
      } else {
        Get.snackbar('Error', 'attachment_deleted_error'.tr);
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred.');
      statusRequest = StatusRequest.failure;
    } finally {
      if (statusRequest != StatusRequest.success) update(['attachments']);
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    startDateController.dispose();
    dueDateController.dispose();
    fileNameController.dispose();
    for (var c in subtaskTitleControllers) {
      c.dispose();
    }
    for (var c in subtaskDescControllers) {
      c.dispose();
    }
    super.onClose();
  }
}
