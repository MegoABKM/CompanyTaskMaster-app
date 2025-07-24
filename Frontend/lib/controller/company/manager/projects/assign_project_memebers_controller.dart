import 'package:get/get.dart';
import 'package:companymanagment/core/class/statusrequest.dart';
import 'package:companymanagment/core/functions/handlingdatacontroller.dart';
import 'package:companymanagment/data/datasource/remote/company/manager/projects_data.dart';
import 'package:companymanagment/data/model/company/companymodel.dart';
import 'package:companymanagment/data/model/company/project_model.dart';

class AssignProjectMembersController extends GetxController {
  late ProjectModel project;
  List<Employees> allCompanyEmployees = [];
  List<Employees> selectedEmployees = [];

  ProjectsData projectsData = ProjectsData(Get.find());
  StatusRequest? statusRequest;

  @override
  void onInit() {
    project = Get.arguments['project'];
    allCompanyEmployees = Get.arguments['allCompanyEmployees'];
    // Initialize the selection with currently assigned members
    selectedEmployees =
        List<Employees>.from(Get.arguments['currentlyAssigned']);
    super.onInit();
  }

  void toggleEmployeeSelection(Employees employee) {
    final isSelected =
        selectedEmployees.any((e) => e.employeeId == employee.employeeId);
    if (isSelected) {
      selectedEmployees.removeWhere((e) => e.employeeId == employee.employeeId);
    } else {
      selectedEmployees.add(employee);
    }
    update();
  }

  Future<void> saveAssignments() async {
    statusRequest = StatusRequest.loading;
    update();

    // Create a comma-separated string of selected employee IDs
    String employeeIds = selectedEmployees.map((e) => e.employeeId!).join(',');

    var response = await projectsData.assignEmployeesToProject(
      project.projectId.toString(),
      employeeIds,
    );

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        Get.back(result: 'success'); // Go back and signal a refresh
        Get.snackbar("Success", "Project members updated successfully.");
      } else {
        Get.snackbar(
            "Error", response['message'] ?? "Failed to update members.");
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
}
