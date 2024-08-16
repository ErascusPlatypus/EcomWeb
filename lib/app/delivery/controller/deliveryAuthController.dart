import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../constants/AppStrings.dart';
import '../../../constants/apiEndPoints.dart';
import '../../../helper/ApiHandler.dart';

class DeliveryAuthController {
  static Future driverLogin(
      {required String email, required String password}) async {
    var data = {
      "email": email,
      "password": password,
    };
    var formData = FormData.fromMap(data);
    try {
      var response =
          await GetDio.getDio().post(ApiEndPoints.baseURL+ApiEndPoints.logindriver, data: formData);
          print(response.data);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return "";
    }
  }
}
