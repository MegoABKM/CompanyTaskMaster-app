import 'package:companymanagment/core/class/crud.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';

class CompanyData {
  Crud crud;
  CompanyData(this.crud);

  insertData(
      String companyname,
      String companynickid,
      String companydiscription,
      String companyimage,
      String companyworkers,
      String companyjob,
      String userid) async {
    var response = await crud.postData(AppLink.createcompany, {
      "companyname": companyname,
      "companynickid": companynickid,
      "companydescription": companydiscription,
      "companyimage": companyimage,
      "companyworkers": companyworkers,
      "companyjob": companyjob,
      "userid": userid,
    });
    return response.fold((l) => l, (r) => r);
  }

  updateData(
      String companyname,
      String companynickid,
      String companydiscription,
      String companyimage,
      String companyworkers,
      String companyjob,
      String companyid) async {
    var response = await crud.postData(AppLink.updatecompany, {
      "companyname": companyname,
      "companynickid": companynickid,
      "companydescription": companydiscription,
      "companyimage": companyimage,
      "companyworkers": companyworkers,
      "companyjob": companyjob,
      "companyid": companyid,
    });
    return response.fold((l) => l, (r) => r);
  }

  removedata(String? id) async {
    var response = await crud.postData(AppLink.deletecompany, {
      "companyid": id,
    });
    return response.fold((l) => l, (r) => r);
  }

  removeemployee(String? employeeid, String? companyid) async {
    var response = await crud.postData(AppLink.deleteemployeecompany,
        {"employeeid": employeeid, "companyid": companyid});
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> nudgeEmployee(String employeeId, String managerName) async {
    var response = await crud.postData(AppLink.nudgeEmployee, {
      "employee_id": employeeId,
      "manager_name": managerName,
    });
    return response.fold((l) => l, (r) => r);
  }
}
