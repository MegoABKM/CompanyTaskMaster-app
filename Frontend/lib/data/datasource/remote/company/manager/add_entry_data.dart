// lib/data/datasource/remote/company/manager/add_entry_data.dart

import 'package:companymanagment/core/class/crud.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';

class AddEntryData {
  Crud crud;
  AddEntryData(this.crud);

  postData(Map<String, String> data) async {
    var response = await crud.postData(AppLink.financeAddEntry, data);
    return response.fold((l) => l, (r) => r);
  }
}
