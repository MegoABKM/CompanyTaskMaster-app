// lib/data/datasource/remote/company/manager/finance_date.dart

import 'package:companymanagment/core/class/crud.dart';
import 'package:companymanagment/data/datasource/remote/linkapi.dart';

class FinanceData {
  Crud crud;
  FinanceData(this.crud);

  getSummary(String companyId) async {
    var response = await crud
        .postData(AppLink.financeGetSummary, {"company_id": companyId});
    return response.fold((l) => l, (r) => r);
  }

  getProjectDetails(String projectId) async {
    var response = await crud
        .postData(AppLink.financeGetProjectDetails, {"project_id": projectId});
    return response.fold((l) => l, (r) => r);
  }

  // NEW: Delete method
  deleteEntry({required int id, required String type}) async {
    var response = await crud.postData(
        AppLink.financeDeleteEntry, {"id": id.toString(), "type": type});
    return response.fold((l) => l, (r) => r);
  }

  // NEW: Update method
  updateEntry({
    required int id,
    required String type,
    required String description,
    required String amount,
    required String date,
    required String category,
  }) async {
    var response = await crud.postData(AppLink.financeUpdateEntry, {
      "id": id.toString(),
      "type": type,
      "description": description,
      "amount": amount,
      "date": date,
      "category": category,
    });
    return response.fold((l) => l, (r) => r);
  }
}
