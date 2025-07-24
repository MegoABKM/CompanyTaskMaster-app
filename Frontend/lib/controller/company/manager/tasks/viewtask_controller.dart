import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/data/datasource/remote/company/taskcompany_data.dart';
import 'package:companymanagment/data/model/company/tasks/assignedemployeemodel.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';
import 'package:companymanagment/data/model/company/tasks/subtasksmode.dart';
import 'package:companymanagment/data/model/company/tasks/taskcompanymodel.dart';
import 'package:companymanagment/data/model/company/tasks/attachmentmodel.dart';
import 'package:companymanagment/view/screen/company/manager/tasks/updatetask/updatetaskcompany.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewTaskCompanyManagerController extends GetxController {
  late TaskCompanyModel taskcompanydetail;
  List<Assignedemployeemodel> assignedemployee = [];
  List<SubtaskModel> subtasks = [];
  List<AttachmentModel> attachments = [];
  List<Employees> companyemployee = [];

  Taskcompanydata viewtaskcompanydata = Taskcompanydata(Get.find());
  StatusRequest? statusRequest;

  @override
  void onInit() {
    taskcompanydetail = Get.arguments['taskcompanydetail'];
    companyemployee = Get.arguments['companyemployee'] ?? [];
    getData();
    super.onInit();
  }

  Future<void> getData() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await viewtaskcompanydata.getDataMan(taskcompanydetail.id);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success &&
        response['status'] == 'success') {
      if (response['task'] != null) {
        taskcompanydetail = TaskCompanyModel.fromJson(response['task']);
      }
      assignedemployee = (response['assignedusers'] as List? ?? [])
          .map((e) => Assignedemployeemodel.fromJson(e))
          .toList();
      subtasks = (response['subtasks'] as List? ?? [])
          .map((e) => SubtaskModel.fromJson(e))
          .toList();
      attachments = (response['attachments'] as List? ?? [])
          .map((e) => AttachmentModel.fromJson(e))
          .toList();
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  void goToUpdateTask() async {
    final result = await Get.to(
      () => const Updatetaskcompany(),
      arguments: {
        'taskcompanydetail': taskcompanydetail,
        'companyemployee': companyemployee,
        'assignedemployee': assignedemployee,
        'subtasks': subtasks,
        'attachments': attachments,
      },
    );

    if (result == 'updated') {
      getData();
    }
  }

  // --- Utility methods for viewing files ---
  // FIX: Add these missing helper methods
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
      Get.snackbar("Error", "Could not launch file.");
    }
  }

  @override
  void onClose() {
    Get.back(result: 'updated');
    super.onClose();
  }
}
