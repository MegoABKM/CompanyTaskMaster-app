import 'package:tasknotate/core/class/crud.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';

class VerifyCodeSignupData {
  late Crud crud;

  VerifyCodeSignupData(this.crud);

  postData(String email, String verifycode) async {
    var response = await crud.postData(
        AppLink.verifycode, {"email": email, "verifycode": verifycode});
    return response.fold((l) => l, (r) => r);
  }

  resend(String email) async {
    var response = await crud.postData(AppLink.resendverifycode, {
      "email": email,
    });
    return response.fold((l) => l, (r) => r);
  }
}
