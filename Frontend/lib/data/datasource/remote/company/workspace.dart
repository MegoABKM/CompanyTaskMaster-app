import 'package:tasknotate/core/class/crud.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';

class WorkspaceData {
  Crud crud;
  WorkspaceData(this.crud);

  getData(String? userid) async {
    var response = await crud.postData(AppLink.workspace, {
      "companyid": userid,
    });
    return response.fold((l) => l, (r) => r);
  }

  getDataEmployee(String? userid) async {
    var response = await crud.postData(AppLink.workspaceemployee, {
      "companyid": userid,
    });
    return response.fold((l) => l, (r) => r);
  }

  deleteData(String? taskid) async {
    var response =
        await crud.postData(AppLink.taskdeletecompany, {"task_id": taskid});
    return response.fold((l) => l, (r) => r);
  }

  Future updateProgress(String? companyid, int completedTasks) async {
    var response = await crud.postData(AppLink.progressbar, {
      "companyid": companyid ?? "",
      "completed_tasks": completedTasks.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }

  insertUpdateTaskStatus(String? taskid, String userid, String taskStatus,
      String? username, String? tasktitle) async {
    var response = await crud.postData(AppLink.employeeInsertUpdateTask, {
      "taskid": taskid,
      "userid": userid,
      "checkstate": taskStatus,
      "username": username,
      "tasktitle": tasktitle,
    });
    return response.fold((l) => l, (r) => r);
  }
}
