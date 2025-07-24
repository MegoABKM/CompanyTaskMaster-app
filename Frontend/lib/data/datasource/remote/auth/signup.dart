import 'package:companymanagment/core/class/crud.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';

class Signupdata {
  Crud crud;

  Signupdata(this.crud);

  postData(String username, String password, String email, String phone) async {
    var response = await crud.postData(AppLink.signup, {
      "username": username,
      "password": password,
      "email": email,
      "phone": phone,
    });
    return response.fold((l) => l, (r) => r);
  }
}
