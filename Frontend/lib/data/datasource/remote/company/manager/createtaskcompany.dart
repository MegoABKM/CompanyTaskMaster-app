import 'package:tasknotate/core/class/crud.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';

class CreatetaskcompanyData {
  Crud crud;
  CreatetaskcompanyData(this.crud);

  // Method to send task data to backend for insertion into database
  Future<dynamic> insertData({
    String? taskcompanyid,
    String? tasktitle,
    String? taskdescription,
    String? taskcreatedon,
    String? taskduedate,
    String? taskpriority,
    String? taskstatus,
    String? tasklastupdate,
    String? tasknotification,
    // String? employeeIds,
  }) async {
    var response = await crud.postData(AppLink.taskcreatecompany, {
      "taskcompanyid": taskcompanyid,
      "tasktitle": tasktitle,
      "taskdescription": taskdescription,
      "taskcreatedon": taskcreatedon,
      "taskduedate": taskduedate,
      "taskpriority": taskpriority,
      "taskstatus": taskstatus,
      "tasklastupdate": tasklastupdate,
      "tasknotification": tasknotification,
      // "employeeIds": employeeIds
    });
    return response.fold((l) => l, (r) => r);
  }
}
