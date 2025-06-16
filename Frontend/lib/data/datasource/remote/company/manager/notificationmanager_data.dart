import 'package:tasknotate/core/class/crud.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';

class NotificationmanagerData {
  Crud crud;
  NotificationmanagerData(this.crud);

  getData(String? userid) async {
    var response = await crud.postData(AppLink.viewnotificationmanager, {
      "userid": userid,
    });
    return response.fold((l) => l, (r) => r);
  }

  // removedata(String? id) async {
  //   var response = await crud.postData(AppLink.managercompany, {
  //     "id": id,
  //   });
  //   return response.fold((l) => l, (r) => r);
  // }
}
