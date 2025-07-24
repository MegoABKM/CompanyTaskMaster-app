import 'package:companymanagment/core/class/crud.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';

class AssigneemployeetotaskData {
  Crud crud;
  AssigneemployeetotaskData(this.crud);

  insertData(String? taskid, String userIds) async {
    var response = await crud.postData(
        AppLink.assigntasktoemployee, {"task_id": taskid, "user_id": userIds});
    return response.fold((l) => l, (r) => r);
  }

  updateData(String? taskid, String userIds) async {
    var response = await crud.postData(AppLink.assigntaskupdateemployee,
        {"task_id": taskid, "user_id": userIds});
    return response.fold((l) => l, (r) => r);
  }
}
