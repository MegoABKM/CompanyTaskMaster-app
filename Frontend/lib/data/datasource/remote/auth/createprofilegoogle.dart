import 'package:companymanagment/core/class/crud.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';

class ProfileSignupData {
  Crud crud;

  ProfileSignupData(this.crud);

  postData(String username, String email, String phone) async {
    var response = await crud.postData(AppLink.signupgoogle, {
      "username": username,
      "email": email,
      "phone": phone,
    });
    return response.fold((l) => l, (r) => r);
  }
}
