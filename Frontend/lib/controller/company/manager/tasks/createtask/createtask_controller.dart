import 'package:get/get.dart';
import 'package:tasknotate/controller/company/manager/tasks/workspacemanager.dart';
import 'package:tasknotate/core/class/statusrequest.dart';
import 'package:tasknotate/core/functions/handlingdatacontroller.dart';
import 'package:tasknotate/data/datasource/remote/company/manager/createtaskcompany.dart';
import 'package:intl/intl.dart';
import 'package:tasknotate/data/model/company/companymodel.dart';
import 'package:tasknotate/data/model/company/tasks/taskcompanymodel.dart'; // Add this import
import 'package:tasknotate/view/screen/company/manager/tasks/createtask/assignemployee.dart';

class CreatetaskController extends GetxController {
  CreatetaskcompanyData createdata = CreatetaskcompanyData(Get.find());
  WorkspaceController workspaceController =
      Get.find<WorkspaceController>(); // Use existing instance
  String? companyid;
  String? taskid;
  // Form fields
  String taskTitle = '';
  String priority = 'Not set';
  String status = 'Pending';
  String description = '';
  String dueDate = '';
  bool sendViaGmail = true;
  bool sendNotification = true;
  StatusRequest? statusRequest;
  // Dropdown items
  List<String> priorityOptions = ["Not set", "High", "Medium", "Low"];
  List<String> statusOptions = ["In Progress", "Completed", "Pending"];

  List<Employees>? employees = [];

  void insertTask() async {
    if (_isFormValid()) {
      try {
        statusRequest = StatusRequest.loading;
        update();

        String taskCreatedOn = DateFormat('yyyy-MM-dd').format(DateTime.now());
        String taskLastUpdate = DateFormat('yyyy-MM-dd').format(DateTime.now());

        print('Sending task data:');
        print('Company ID: $companyid');
        print('Title: $taskTitle');
        print('Description: $description');
        print('Due Date: $dueDate');

        var response = await createdata.insertData(
          taskcompanyid: companyid,
          tasktitle: taskTitle,
          taskdescription: description,
          taskcreatedon: taskCreatedOn,
          taskduedate: dueDate,
          taskpriority: priority,
          taskstatus: status,
          tasklastupdate: taskLastUpdate,
          tasknotification: sendNotification.toString(),
        );

        print('Raw response: $response');

        statusRequest = handlingData(response);
        update();

        if (statusRequest == StatusRequest.success) {
          if (response['status'] == 'success') {
            taskid = response['task_id'].toString();
            print('Task created with ID: $taskid');

            // Create a new TaskCompanyModel from the form data
            TaskCompanyModel newTask = TaskCompanyModel(
              id: taskid, // Assuming task_id is an integer
              companyId: companyid,
              title: taskTitle,
              description: description,
              createdOn: taskCreatedOn,
              dueDate: dueDate,
              priority: priority,
              status: status,
              lastUpdated: taskLastUpdate,
            );
            workspaceController.taskcompany.insert(0, newTask);
            if (newTask.status == "Completed") {
              workspaceController.completedTasks++;
            }
            workspaceController.progress =
                workspaceController.taskcompany.isNotEmpty
                    ? ((workspaceController.completedTasks /
                                workspaceController.taskcompany.length) *
                            100)
                        .round()
                    : 0;
            workspaceController.update();

            Get.snackbar('Success', 'Task created successfully');
            goToAssignEmployeeTask();
          } else {
            Get.snackbar('Error',
                'Server returned failure: ${response['message'] ?? 'Unknown error'}');
          }
        } else {
          Get.snackbar('Error', 'Request failed: $statusRequest');
        }
      } catch (e) {
        statusRequest = StatusRequest.failure;
        update();
        print('Exception caught: $e');
        Get.snackbar('Error', 'An error occurred: $e');
      }
    } else {
      Get.snackbar('Validation Error', 'Please fill all required fields');
    }
  }

  // Validation for form
  bool _isFormValid() {
    return taskTitle.isNotEmpty;
  }

  // Methods to update form data
  void updateTaskTitle(String title) {
    taskTitle = title;
    update();
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
    update();
  }

  void updateDueDate(String newDueDate) {
    dueDate = newDueDate;
    update();
  }

  void updateSendViaGmail(bool value) {
    sendViaGmail = value;
    update();
  }

  void updateSendNotification(bool value) {
    sendNotification = value;
    update();
  }

  void goToAssignEmployeeTask() {
    Get.off(const AssignemployeeToTask(),
        arguments: {"taskid": taskid, "companyemployee": employees});
  }

  @override
  void onInit() {
    companyid = Get.arguments['companyid'];
    employees = Get.arguments['companyemployee'];
    super.onInit();
  }
}
