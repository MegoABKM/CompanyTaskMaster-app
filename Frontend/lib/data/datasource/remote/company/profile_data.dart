import 'package:companymanagment/core/class/crud.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';

class ProfileData {
  Crud crud;
  ProfileData(this.crud);

  updateData(String? userid, String? username, String? userphone,
      String? userimage) async {
    var response = await crud.postData(AppLink.updateprofile, {
      "userid": userid,
      "username": username,
      "userphone": userphone,
      "userimage": userimage,
    });
    return response.fold((l) => l, (r) => r);
  }

  getDataManager(String? userid) async {
    var response = await crud.postData(AppLink.viewprofile, {
      "userid": userid,
    });
    return response.fold((l) => l, (r) => r);
  }
}
