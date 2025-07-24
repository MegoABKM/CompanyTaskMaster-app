import 'package:companymanagment/core/class/crud.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';

class ProjectsData {
  Crud crud;
  ProjectsData(this.crud);

  getAllProjects(String companyId) async {
    var response = await crud.postData(AppLink.projectgetall, {
      "company_id": companyId,
    });
    return response.fold((l) => l, (r) => r);
  }

  createProject(
      String name,
      String description,
      String companyId,
      String managerId,
      String? deadline,
      String priority,
      String methodologyType,
      String? budget) async {
    var response = await crud.postData(AppLink.projectcreate, {
      "project_name": name,
      "project_description": description,
      "company_id": companyId,
      "manager_id": managerId,
      "deadline": deadline ?? "",
      "priority": priority,
      "methodology_type": methodologyType,
      "budget": budget ?? "0", // NEW
    });
    return response.fold((l) => l, (r) => r);
  }

  // NEW: Method to assign employees to a project
  assignEmployeesToProject(String projectId, String employeeIds) async {
    var response = await crud.postData(AppLink.assignToProject, {
      "project_id": projectId,
      "employee_ids": employeeIds,
    });
    return response.fold((l) => l, (r) => r);
  }

  // NEW: Update project details
  updateProject({
    required String projectId,
    required String name,
    required String description,
    String? deadline,
    required String priority,
  }) async {
    var response = await crud.postData(AppLink.projectUpdate, {
      "project_id": projectId,
      "project_name": name,
      "project_description": description,
      "deadline": deadline ?? "",
      "priority": priority,
    });
    return response.fold((l) => l, (r) => r);
  }

  // NEW: Delete a project
  deleteProject(String projectId) async {
    var response = await crud.postData(AppLink.projectDelete, {
      "project_id": projectId,
    });
    return response.fold((l) => l, (r) => r);
  }

  // NEW: Update project status (for archiving)
  updateProjectStatus(String projectId, String status) async {
    var response = await crud.postData(AppLink.projectUpdateStatus, {
      "project_id": projectId,
      "status": status,
    });
    return response.fold((l) => l, (r) => r);
  }
}
