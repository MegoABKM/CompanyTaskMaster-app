import 'package:tasknotate/core/class/crud.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';

class EmployeehomeData {
  Crud crud;
  EmployeehomeData(this.crud);

  getData(String? userid) async {
    var response = await crud.postData(AppLink.employeehome, {
      "userid": userid,
    });
    return response.fold((l) => l, (r) => r);
  }

  requestJoinToCompany(String? userid, String companyid) async {
    var response = await crud.postData(AppLink.empjoinrequest, {
      "userid": userid,
      "companyid": companyid,
    });
    return response.fold((l) => l, (r) => r);
  }
}
