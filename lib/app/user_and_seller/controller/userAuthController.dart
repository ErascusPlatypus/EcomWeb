import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/AppStrings.dart';
import '../../../constants/apiEndPoints.dart';
import '../../../helper/ApiHandler.dart';

class UserAuthController {
  static Future userLogin(String email, String password) async {
    var data = {
      "email": email,
      "password": password,
    };
    var formData = FormData.fromMap(data);
    try {
      var response =
          await GetDio.getDio().post(ApiEndPoints.baseURL+ApiEndPoints.loginapi, data: formData);
      var decodedResponse = jsonDecode(response.data);
      print("decodedResponse$decodedResponse");
      return decodedResponse;
    } catch (e) {
      print(e);
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static Future RegisterUser(
      {required String email,
      required String password,
      required String code,
      required String name,
      required String phone}) async {
    var postData = {
      "name": name,
      "email": email,
      "password": password,
      "code": code,
      "phone": phone
    };
    var formData = FormData.fromMap(postData);
    try {
      final response =
          await GetDio.getDio().post(ApiEndPoints.baseURL+ApiEndPoints.registerapi, data: formData);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static Future userOwnerLogin(
      {required String email, required String password}) async {
    var data = {
      "email": email,
      "password": password,
    };
    var formData = FormData.fromMap(data);
    try {
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.loginapiowner, data: formData);
      var decodedResponse = jsonDecode(response.data);
      return decodedResponse;
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static Future registerApiOwner(data) async {
    var formData = FormData.fromMap(data);
    try {
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.registrationapiowner, data: formData);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static Future<void> storeUserData(
      String id, String name, String email, String userType,
      {String? profile}) async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setString('userId', id);
    _prefs.setString('userName', name);
    _prefs.setString('userEmail', email);
    _prefs.setString('userType', userType);
    _prefs.setString('profile', profile ?? '');
  }

  static Future registerServiceEmployee({
    required String email,
    required String name,
    required String phone,
    required String password,
    required String service_id,
  }) async {
    final _prefs = await SharedPreferences.getInstance();
    var postData = {
      "email": email,
      "name": name,
      'phone': phone,
      'password': password,
      "seller_id": int.parse(await _prefs.getString('userId') ?? ''),
      'service_id': int.parse(service_id)
    };
    var formData = FormData.fromMap(postData);
    try {
      final response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.addServiceEmployees, data: formData);
      return response.data;
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static Future forgotPassword({required email}) async {
    var postData = {
      "email": email,
    };
    var formData = FormData.fromMap(postData);
    try {
      final response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.forgot_password, data: formData);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static resetPassword({required email, required password}) async {
    var postData = {"email": email, "password": password};
    var formData = FormData.fromMap(postData);
    try {
      final response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.resetPassword, data: formData);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static acceptDelivery({required String order_id}) async {
    var postData = {"order_id": order_id};
    var formData = FormData.fromMap(postData);
    try {
      final response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.accept_delivery_request, data: formData);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static completeDelivery({required String order_id}) async {
    var postData = {"order_id": order_id};
    var formData = FormData.fromMap(postData);
    try {
      final response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.complete_delivery, data: formData);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static acceptRepairOrder({required String repair_id}) async {
    var postData = {"repair_id": repair_id};
    var formData = FormData.fromMap(postData);
    try {
      final response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.accept_repair_request, data: formData);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static completeRepairOrder({required String repair_id}) async {
    var postData = {"repair_id": repair_id};
    var formData = FormData.fromMap(postData);
    try {
      final response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.complete_repair, data: formData);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }
}
