import 'package:get/get.dart';
import 'package:companymanagment/controller/company/manager/tasks/workspacemanager.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/core/services/services.dart';
import 'package:companymanagment/data/datasource/remote/company/taskcompany_data.dart';
import 'package:companymanagment/data/model/company/tasks/assignedemployeemodel.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';
import 'package:companymanagment/data/model/company/tasks/newtasksmodel.dart';
import 'package:companymanagment/data/model/company/tasks/subtasksmode.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';
import 'package:companymanagment/data/model/company/tasks/attachmentmodel.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewtaskEmpController extends GetxController {
  List<Assignedemployeemodel> assignedemployee = [];
  Newtasks? newtasks;
  TaskCompanyModel? taskcompanydetail;
  List<SubtaskModel> subtasks = [];
  List<AttachmentModel> attachments = [];
  List<Employees>? companyemployee = [];
  Taskcompanydata viewtaskcompanydata = Taskcompanydata(Get.find());
  StatusRequest? statusRequest;
  String? from;
  MyServices myServices = Get.find();

  Future<void> getData() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await viewtaskcompanydata.getDataEmp(taskcompanydetail!.id);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      try {
        assignedemployee = (response['assignedusers'] as List)
            .map((e) => Assignedemployeemodel.fromJson(e))
            .toList();
        subtasks = (response['subtasks'] as List)
            .map((e) => SubtaskModel.fromJson(e))
            .toList();
        attachments = (response['attachments'] as List)
            .map((e) => AttachmentModel.fromJson(e))
            .toList();

        update();
        print("Fetched Company Data: $assignedemployee");
        print("Fetched Subtasks: $subtasks");
        print("Fetched Attachments: $attachments");
      } catch (e) {
        print("Error parsing response data: $e");
        statusRequest = StatusRequest.failure;
      }
    } else {
      print("Failed to fetch data: $statusRequest");
    }
    update();
  }

  Future<void> getDataNewTask() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await viewtaskcompanydata.getDataEmp(
        newtasks!.taskId.toString()); // Assuming newtasks contains taskId
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      try {
        assignedemployee = (response['assignedusers'] as List)
            .map((e) => Assignedemployeemodel.fromJson(e))
            .toList();
        subtasks = (response['subtasks'] as List)
            .map((e) => SubtaskModel.fromJson(e))
            .toList();
        attachments = (response['attachments'] as List)
            .map((e) => AttachmentModel.fromJson(e))
            .toList();

        update();
        print("Fetched New Task Data: $assignedemployee");
        print("Fetched Subtasks: $subtasks");
        print("Fetched Attachments: $attachments");
      } catch (e) {
        print("Error parsing response data: $e");
        statusRequest = StatusRequest.failure;
      }
    } else {
      print("Failed to fetch data: $statusRequest");
    }
    update();
  }

  bool isImage(String filename) {
    final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];
    return imageExtensions.any((ext) => filename.toLowerCase().endsWith(ext));
  }

  bool isVideo(String filename) {
    final videoExtensions = ['.mp4', '.mov', '.avi', '.mkv', '.flv', '.wmv'];
    return videoExtensions.any((ext) => filename.toLowerCase().endsWith(ext));
  }

  String getCompanyFileUrl(String fileurl) {
    return '${AppLink.server}/$fileurl';
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
    }
  }

  void goToWorkSpace() {
    Get.back(
      result: {
        'companyid': taskcompanydetail!.companyId,
        "companyemployee": companyemployee,
      },
    );

    if (Get.isRegistered<WorkspaceController>()) {
      Get.delete<WorkspaceController>();
    }
  }

  void goToHome() {
    // Get.offAllNamed(AppRoute.home);
  }

  @override
  void onInit() {
    super.onInit();

    from = Get.arguments['from'];

    if (from == "employee") {
      newtasks = Get.arguments['newtasks'];
      getDataNewTask();
    }

    taskcompanydetail = Get.arguments['taskcompanydetail'];
    companyemployee = Get.arguments['companyemployee'];

    if (from == "update") {
      assignedemployee = Get.arguments['assignedemployee'];
      subtasks = Get.arguments['subtasks'];
      attachments = Get.arguments['attachments'];
      update();
    } else {
      getData();
    }
  }
}
