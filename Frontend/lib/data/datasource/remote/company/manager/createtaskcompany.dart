import 'package:companymanagment/core/class/crud.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';

class CreatetaskcompanyData {
  Crud crud;
  CreatetaskcompanyData(this.crud);

  Future<dynamic> insertData({
    String? taskcompanyid,
    String? projectId, // NEW
    String? tasktitle,
    String? taskdescription,
    String? taskcreatedon,
    String? taskstartdate,
    String? taskduedate,
    String? taskpriority,
    String? taskstatus,
    String? tasklastupdate,
    String? tasknotification,
  }) async {
    var response = await crud.postData(AppLink.taskcreatecompany, {
      "taskcompanyid": taskcompanyid,
      "project_id": projectId, // NEW
      "tasktitle": tasktitle,
      "taskdescription": taskdescription,
      "taskcreatedon": taskcreatedon,
      "taskstartdate": taskstartdate,
      "taskduedate": taskduedate,
      "taskpriority": taskpriority,
      "taskstatus": taskstatus,
      "tasklastupdate": tasklastupdate,
      "tasknotification": tasknotification,
    });
    return response.fold((l) => l, (r) => r);
  }
}
