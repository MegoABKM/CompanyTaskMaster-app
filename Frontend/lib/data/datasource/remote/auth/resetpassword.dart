import 'package:tasknotate/core/class/crud.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';

class ResetPasswordData {
  late Crud crud;

  ResetPasswordData(this.crud);

  postData(String email, String password) async {
    var response = await crud.postData(
        AppLink.resetpassword, {"email": email, "password": password});
    return response.fold((l) => l, (r) => r);
  }
}
