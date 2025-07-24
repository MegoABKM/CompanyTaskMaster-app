import 'package:companymanagment/core/class/crud.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';

class Taskcompanydata {
  Crud crud;
  Taskcompanydata(this.crud);

  getDataMan(String? taskid) async {
    var response =
        await crud.postData(AppLink.taskviewdetails, {"taskid": taskid});
    return response.fold((l) => l, (r) => r);
  }

  getDataEmp(String? taskid) async {
    var response =
        await crud.postData(AppLink.employeeviewtask, {"taskid": taskid});
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> updateData({
    String? taskid,
    String? tasktitle,
    String? taskdescription,
    String? taskstartdate,
    String? taskduedate,
    String? taskpriority,
    String? taskstatus,
    String? tasklastupdate,
    String? companyid,
  }) async {
    var response = await crud.postData(AppLink.taskupdatecompany, {
      "taskid": taskid,
      "tasktitle": tasktitle,
      "taskdescription": taskdescription,
      "taskstartdate": taskstartdate,
      "taskduedate": taskduedate,
      "taskpriority": taskpriority,
      "taskstatus": taskstatus,
      "tasklastupdate": tasklastupdate,
      "companyid": companyid,
    });
    return response.fold((l) => l, (r) => r);
  }

  // NEW METHOD
  Future<dynamic> assignTaskToSprint(String taskId, String sprintId) async {
    var response = await crud.postData(AppLink.assignToSprint, {
      "task_id": taskId,
      "sprint_id": sprintId,
    });
    return response.fold((l) => l, (r) => r);
  }
}
