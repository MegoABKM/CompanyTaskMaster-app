import 'package:companymanagment/core/class/crud.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';

class RequestjoinData {
  Crud crud;
  RequestjoinData(this.crud);

  rejectUser(String? employeecompanyid, String? id) async {
    var response = await crud.postData(AppLink.rejectrequestjoin, {
      "employeecompanyid": employeecompanyid,
      "employeeid": id,
    });
    return response.fold((l) => l, (r) => r);
  }

  getData(String? userid) async {
    var response = await crud.postData(AppLink.showrequestjoin, {
      "userid": userid,
    });
    return response.fold((l) => l, (r) => r);
  }

  acceptUser(String? employeecompanyid, String? id) async {
    var response = await crud.postData(AppLink.acceptrequestjoin, {
      "employeecompanyid": employeecompanyid,
      "employeeid": id,
    });
    return response.fold((l) => l, (r) => r);
  }
}
