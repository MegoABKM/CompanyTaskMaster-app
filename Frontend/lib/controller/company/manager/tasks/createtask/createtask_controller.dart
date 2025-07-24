import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/createtaskcompany.dart';
import 'package:intl/intl.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';

class CreatetaskController extends GetxController {
  CreatetaskcompanyData createdata = CreatetaskcompanyData(Get.find());

  String? companyid;
  String? projectid;

  // Form fields
  String taskTitle = '';
  String priority = 'Medium'; // Default priority
  String status = 'Pending'; // Default status
  String description = '';
  String dueDate = '';
  String startDate = '';
  bool sendNotification = true;
  StatusRequest? statusRequest;

  // Dropdown items
  List<String> priorityOptions = ["Low", "Medium", "High", "Critical"];
  List<String> statusOptions = ["Pending", "In Progress", "Completed"];
  List<Employees> employees = [];

  void insertTask() async {
    if (taskTitle.isEmpty) {
      Get.snackbar('Validation Error', 'Task Title cannot be empty.');
      return;
    }
    try {
      statusRequest = StatusRequest.loading;
      update();

      String taskCreatedOn =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

      var response = await createdata.insertData(
        taskcompanyid: companyid,
        projectId: projectid,
        tasktitle: taskTitle,
        taskdescription: description,
        taskcreatedon: taskCreatedOn,
        taskstartdate: startDate,
        taskduedate: dueDate,
        taskpriority: priority,
        taskstatus: status,
        tasklastupdate: taskCreatedOn,
        tasknotification: sendNotification.toString(),
      );

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success &&
          response['status'] == 'success') {
        Get.back(result: 'created_task'); // Go back and signal success
        Get.snackbar('Success', 'Task created successfully');
      } else {
        Get.snackbar('Error',
            'Server returned failure: ${response['message'] ?? 'Unknown error'}');
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      update();
    }
  }

  void updateTaskTitle(String title) {
    taskTitle = title;
  }

  void updatePriority(String newPriority) {
    priority = newPriority;
    update();
  }

  void updateStatus(String newStatus) {
    status = newStatus;
    update();
  }

  void updateDescription(String newDescription) {
    description = newDescription;
  }

  void updateStartDate(String newStartDate) {
    // <-- ADD THIS NEW METHOD
    startDate = newStartDate;
    update();
  }

  void updateDueDate(String newDueDate) {
    dueDate = newDueDate;
    update();
  }

  void updateSendNotification(bool value) {
    sendNotification = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      companyid = Get.arguments['companyid'];
      projectid = Get.arguments['projectid'];
      employees = Get.arguments['companyemployee'] ?? [];
    }
  }
}
