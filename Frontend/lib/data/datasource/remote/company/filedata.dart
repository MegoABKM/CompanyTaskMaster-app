import 'package:tasknotate/core/class/crud.dart';
import 'package:tasknotate/data/datasource/remote/linkapi.dart';

class Filedata {
  Crud crud;
  Filedata(this.crud);

  removedata(String? id) async {
    var response = await crud.postData(AppLink.deletefile, {
      "id": id,
    });
    return response.fold((l) => l, (r) => r);
  }

  getData(String? taskid) async {
    var response = await crud.postData(AppLink.getfiledata, {
      "taskid": taskid,
    });
    return response.fold((l) => l, (r) => r);
  }

  updateData(String? attachmentid, String? attachmentname) async {
    var response = await crud.postData(AppLink.updatefilename, {
      "id": attachmentid,
      "filename": attachmentname,
    });
    return response.fold((l) => l, (r) => r);
  }
}
