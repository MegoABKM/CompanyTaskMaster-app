import 'package:companymanagment/core/class/crud.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';

class SprintsData {
  Crud crud;
  SprintsData(this.crud);

  createSprint({
    required String projectId,
    required String sprintName,
    String? sprintGoal,
    required String startDate,
    required String endDate,
  }) async {
    var response = await crud.postData(AppLink.sprintcreate, {
      "project_id": projectId,
      "sprint_name": sprintName,
      "sprint_goal": sprintGoal ?? "",
      "start_date": startDate,
      "end_date": endDate,
    });
    return response.fold((l) => l, (r) => r);
  }

  // NEW: Update sprint details
  updateSprint({
    required String sprintId,
    required String sprintName,
    String? sprintGoal,
    required String startDate,
    required String endDate,
  }) async {
    var response = await crud.postData(AppLink.sprintUpdate, {
      "sprint_id": sprintId,
      "sprint_name": sprintName,
      "sprint_goal": sprintGoal ?? "",
      "start_date": startDate,
      "end_date": endDate,
    });
    return response.fold((l) => l, (r) => r);
  }

  // NEW: Update sprint status
  updateSprintStatus({
    required String sprintId,
    required String status,
  }) async {
    var response = await crud.postData(AppLink.sprintUpdateStatus, {
      "sprint_id": sprintId,
      "status": status,
    });
    return response.fold((l) => l, (r) => r);
  }

  // NEW: Delete a sprint
  deleteSprint(String sprintId) async {
    var response = await crud.postData(AppLink.sprintDelete, {
      "sprint_id": sprintId,
    });
    return response.fold((l) => l, (r) => r);
  }

  updateSprintTasks({
    required String sprintId,
    required String taskIds,
  }) async {
    var response = await crud.postData(AppLink.sprintUpdateTasks, {
      "sprint_id": sprintId,
      "task_ids": taskIds, // A comma-separated string of task IDs
    });
    return response.fold((l) => l, (r) => r);
  }
}
