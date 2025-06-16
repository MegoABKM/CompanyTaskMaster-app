import 'package:tasknotate/core/class/crud.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';

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
      "taskduedate": taskduedate,
      "taskpriority": taskpriority,
      "taskstatus": taskstatus,
      "tasklastupdate": tasklastupdate,
      "companyid": companyid,
    });
    return response.fold((l) => l, (r) => r);
  }
}
