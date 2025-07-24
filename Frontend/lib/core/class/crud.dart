import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:companymanagment/core/class/statusrequest.dart';
// import 'package:companymanagment/core/functions/checkinternet.dart';

//dartz to make the function take two declaration to return two things
class Crud {
// the data that will return is json , json is a map that have data but why we need statusrequest?  if the request (loading,failure) we will know if its working or failure ,/
//it will only return one thing map or statusrequest
  Future<Either<StatusRequest, Map>> postData(linkurl, data) async {
    try {
      var response = await http.post(
        Uri.parse(linkurl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
        }, // Adjust if needed
        body: data,
      );

      print("Response Status: ${response.statusCode}");
      print("Response Headers: ${response.headers}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          Map responsebody = jsonDecode(response.body);
          print("Parsed Response Body: $responsebody");
          return Right(responsebody);
        } catch (e) {
          print("JSON Decoding Error: $e");
          return const Left(StatusRequest.serverExeption);
        }
      } else {
        print("Server Failure with Status Code: ${response.statusCode}");
        return const Left(StatusRequest.serverfailure);
      }
    } catch (e) {
      print("Request Error: $e");
      return const Left(StatusRequest.serverExeption);
    }
  }
}
