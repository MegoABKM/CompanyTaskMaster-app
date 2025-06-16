import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/tasks/workspacemanager.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/functions/handlingdatacontroller.dart';
import 'package:tasknotate/core/services/services.dart';
import 'package:tasknotate/data/datasource/remote/company/taskcompany_data.dart';
import 'package:tasknotate/data/model/company/tasks/assignedemployeemodel.dart';
import 'package:tasknotate/data/model/company/companymodel.dart';
import 'package:tasknotate/data/model/company/tasks/subtasksmode.dart';
import 'package:tasknotate/data/model/company/tasks/taskcompanymodel.dart';
import 'package:tasknotate/data/model/company/tasks/attachmentmodel.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';
import 'package:tasknotate/view/screen/company/manager/tasks/updatetask/assignemployeeupdate.dart';
import 'package:tasknotate/view/screen/company/manager/tasks/updatetask/updatefiletotask.dart';
import 'package:tasknotate/view/screen/company/manager/tasks/updatetask/updatesubtask.dart';
import 'package:tasknotate/view/screen/company/manager/tasks/updatetask/updatetaskcompany.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewTaskCompanyManagerController extends GetxController {
  List<Assignedemployeemodel> assignedemployee = [];
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

    var response = await viewtaskcompanydata.getDataMan(taskcompanydetail!.id);
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

  goToUpdateAssignedEmp() {
    Get.to(const AssignemployeeUpdateToTask(), arguments: {
      'taskcompanydetail': taskcompanydetail,
      "companyemployee": companyemployee,
      'assignedemployee': assignedemployee,
      'subtasks': subtasks,
      'attachments': attachments,
      'taskid': taskcompanydetail!.id,
      'from': "edit"
    });
  }

  goToUpdateSubtasks() {
    Get.to(const UpdatesubtaskView(), arguments: {
      'taskcompanydetail': taskcompanydetail,
      "companyemployee": companyemployee,
      'assignedemployee': assignedemployee,
      'subtasks': subtasks,
      'attachments': attachments,
      'taskid': taskcompanydetail!.id,
      'from': "edit"
    });
  }

  goToUpdateFile() {
    Get.to(UpdateFileToTask(), arguments: {
      'taskcompanydetail': taskcompanydetail,
      "companyemployee": companyemployee,
      'assignedemployee': assignedemployee,
      'subtasks': subtasks,
      'attachments': attachments,
      'taskid': taskcompanydetail!.id,
      'from': "edit"
    });
  }

  goToUpdatetask(String from) {
    Get.to(const Updatetaskcompany(), arguments: {
      'taskcompanydetail': taskcompanydetail,
      "companyemployee": companyemployee,
      'assignedemployee': assignedemployee,
      'subtasks': subtasks,
      'attachments': attachments,
      'from': from,
    });
  }

  void goToWorkSpace() {
    // Send arguments to the previous page using Get.back
    Get.back(
      result: {
        'companyid': taskcompanydetail!.companyId,
        "companyemployee": companyemployee,
      },
    );

    // Delete the WorkspaceController if it exists
    if (Get.isRegistered<WorkspaceController>()) {
      Get.delete<WorkspaceController>();
    }
  }

  @override
  void onInit() {
    super.onInit();

    // Fetch updated data
    taskcompanydetail = Get.arguments['taskcompanydetail'];
    companyemployee = Get.arguments['companyemployee'];
    from = Get.arguments['from'];

    if (from == "update") {
      assignedemployee = Get.arguments['assignedemployee'];
      subtasks = Get.arguments['subtasks'];
      attachments = Get.arguments['attachments'];
      update();
    } else {
      getData();
    }

    print("onInit triggered with updated arguments");
  }
}
