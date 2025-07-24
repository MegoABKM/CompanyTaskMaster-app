import 'package:companymanagment/core/class/crud.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';

class LoginData {
  Crud crud;

  LoginData(this.crud);

  postData(String email, String password) async {
    var response = await crud.postData(AppLink.login, {
      "email": email,
      "password": password,
    });
    return response.fold((l) => l, (r) => r);
  }

  checkGoogleToNotCreateProfile(String email) async {
    var response = await crud.postData(AppLink.checksignupgoogle, {
      "email": email,
    });
    return response.fold((l) => l, (r) => r);
  }
}
