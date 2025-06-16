import 'package:tasknotate/core/class/crud.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';

class VerifyCodeResetData {
  late Crud crud;

  VerifyCodeResetData(this.crud);

  postData(String email, String verifycode) async {
    var response = await crud.postData(AppLink.verifycoderesetpassword,
        {"email": email, "verifycode": verifycode});
    return response.fold((l) => l, (r) => r);
  }
}
