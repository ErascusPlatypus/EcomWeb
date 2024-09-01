import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_int2/app/user_and_seller/model/servicemen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/AppStrings.dart';
import '../../../constants/apiEndPoints.dart';
import '../../../helper/ApiHandler.dart';
import '../model/Seller.dart';
import '../model/UserSoldProducts.dart';
import '../model/Users.dart';
import '../model/appointmentUserModel.dart';
import '../model/orderDetails.dart';
import '../model/pendingRequests.dart';
import '../model/products.dart';
import '../model/sell_item_data.dart';
import '../model/services.dart';

class UserController {
  static Future<List<AppointmentsUser>> getAppointments(String email) async {
    var postData = {
      'email': email,
    };
    var formData = FormData.fromMap(postData);
    try {
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.appointments_user, data: formData);
      return appointmentsUserFromJson(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return <AppointmentsUser>[];
    }
  }

  static Future<List<AppointmentsUser>> getAppointmentsForService(
      String email) async {
    var postData = {
      'email': email,
    };
    var formData = FormData.fromMap(postData);
    try {
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.appointments_service, data: formData);
      return appointmentsUserFromJson(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return <AppointmentsUser>[];
    }
  }

  static Future<List<Products>> fetchAllCartItems() async {
    try {
      var response = await GetDio.getDio().get(ApiEndPoints.baseURL+ApiEndPoints.appointments_user);
      return productsFromJson(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return <Products>[];
    }
  }

  static Future<List<Products>> fetchAllProductsForRecomended() async {
    try {
      var response = await GetDio.getDio().get(ApiEndPoints.baseURL+ApiEndPoints.product_list2);
      return productsFromJson(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return <Products>[];
    }
  }

  static Future<List<Products>> fetchAllProducts() async {
    try {
      var response = await GetDio.getDio().get(ApiEndPoints.baseURL+ApiEndPoints.product_list);

      return productsFromJson(response.data);
    } catch (e) {
      print(e.toString());
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return <Products>[];
    }
  }

  static Future<List<RepairApi>> fetchAllServices() async {
    try {
      var response = await GetDio.getDio().get(ApiEndPoints.baseURL+ApiEndPoints.repairapi);
      return repairApiFromJson(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return <RepairApi>[];
    }
  }

  static Future<List<RepairApi>> getSellerServices() async {
    try {
      final _prefs = await SharedPreferences.getInstance();
      var postData = {'sellerId': await _prefs.getString('userId') ?? ''};
      var formData = FormData.fromMap(postData);
      var response =
          await GetDio.getDio().post(ApiEndPoints.baseURL+ApiEndPoints.repairapi, data: formData);
      return repairApiFromJson(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return <RepairApi>[];
    }
  }

  static Future<List<Category1>> fetchAllCategory() async {
    try {
      var response = await GetDio.getDio().get(ApiEndPoints.baseURL+ApiEndPoints.categoryapi);
      return categoryFromJson(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return <Category1>[];
    }
  }

  static Future<List<Users>> fetchAllUsers() async {
    try {
      var response = await GetDio.getDio().get(ApiEndPoints.baseURL+ApiEndPoints.userapi);
         return usersFromJson(response.data);
    } catch (e) {
      print(e);
      print("object");
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return <Users>[];
    }
  }

  static Future<List<Seller>> fetchAllSeller() async {
    try {
      var response = await GetDio.getDio().get(ApiEndPoints.baseURL+ApiEndPoints.sellerapi);

      return sellerFromJson(response.data.toString());
    } catch (e) {
      print(e.toString());
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return <Seller>[];
    }
  }

  static Future<List<ProductsUser>> fetchAllProductsUser() async {
    try {
      var response = await GetDio.getDio().get(ApiEndPoints.baseURL+ApiEndPoints.user_products_list);
      return productsUserFromJson(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return <ProductsUser>[];
    }
  }

  static Future confirmSendMessage(postData) async {
    var formData = FormData.fromMap(postData);
    try {
      var response =
          await GetDio.getDio().post(ApiEndPoints.baseURL+ApiEndPoints.send_message_new, data: formData);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static Future confirmRepairRequest(postData) async {
    var formData = FormData.fromMap(postData);
    try {
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.repair_request, data: formData);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static Future rescheduleRepairRequest(postData) async {
    var formData = FormData.fromMap(postData);
    try {
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.reschedule_repair_order, data: formData);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static Future rejectRepair(String rid) async {
    var postData = {
      'rid': rid,
    };
    var formData = FormData.fromMap(postData);
    try {
      await GetDio.getDio().post(ApiEndPoints.baseURL+ApiEndPoints.reject_request, data: formData);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static Future<List<PendingRequests>> postEmail(String email) async {
    var postData = {
      'email': email,
    };
    var formData = FormData.fromMap(postData);
    try {
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.pendingrequests, data: formData);
      return pendingRequestsFromJson(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return <PendingRequests>[];
    }
  }

  static Future<List<PendingRequests>> pendingRequestsForService(
      String email, String serviceId) async {
    var postData = {'email': email, 'serviceId': serviceId};
    var formData = FormData.fromMap(postData);
    try {
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.pendingrequests, data: formData);
      return pendingRequestsFromJson(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return <PendingRequests>[];
    }
  }

  static Future<List<OrderDetails>> fetchOrderHistory(String email) async {
    var postData = {
      'email': email,
    };
    var formData = FormData.fromMap(postData);
    try {
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.fetch_orders, data: formData);
      return orderDetailsFromJson(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return <OrderDetails>[];
    }
  }

  static Future sellItem(postData) async {
    var formData = FormData.fromMap(postData);
    try {
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.sell_item_api, data: formData);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static Future updateItem(postData) async {
    var formData = FormData.fromMap(postData);
    try {
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.update_item_api, data: formData);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static Future updateGSTShop(postData) async {
    var formData = FormData.fromMap(postData);
    try {
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.update_gst_shop, data: formData);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static Future changeRepairDateTime(postData) async {
    var formData = FormData.fromMap(postData);
    try {
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.change_repair_time_date, data: formData);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static Future fetchProfile(String email) async {
    var postData = {
      'email': email,
    };
    var formData = FormData.fromMap(postData);
    try {
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.fetch_seller_profile, data: formData);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static Future fetchWallet(String email) async {
    var postData = {
      'email': email,
    };
    var formData = FormData.fromMap(postData);
    try {
      var response =
          await GetDio.getDio().post(ApiEndPoints.baseURL+ApiEndPoints.fetch_wallet, data: formData);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static Future removeFromCart({required String pid}) async {
    final _prefs = await SharedPreferences.getInstance();

    var postData = {
      'email': await _prefs.getString('userEmail') ?? '',
      'pid': pid,
    };
    var formData = FormData.fromMap(postData);
    try {
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.remove_from_cart, data: formData);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static Future uploadContacts(postData) async {
    try {
      var response =
          await GetDio.getDio().post(ApiEndPoints.baseURL+ApiEndPoints.usercontact, data: postData);
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  static Future uploadUserProfile(image) async {
    try {
      final _prefs = await SharedPreferences.getInstance();
      var postData = {
        'key': '6d207e02198a847aa98d0a2a901485a5',
        'source': image,
      };

      var formdata = FormData.fromMap(postData);
      var response = await GetDio.getDio()
          .post('https://freeimage.host/api/1/upload', data: formdata);
      print(jsonDecode(response.data)['image']);
      print(jsonDecode(response.data)['image']['url']);
      var url = jsonDecode(response.data)['image']['url'];

      var postDatas = {
        'url': url,
        'userId': await _prefs.getString('userId') ?? ''
      };

      var formdatas = FormData.fromMap(postDatas);
      await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.update_user_profile, data: formdatas);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }

  // to list service men with particular service

  static Future<List<ServiceMen>> getSellerServicemenList(
      String serviceId) async {
    try {
      final _prefs = await SharedPreferences.getInstance();
      var postData = {
        'seller_id': await _prefs.getString('userId') ?? '',
        "service_id": serviceId
      };
      var formData = FormData.fromMap(postData);
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.fetchServiceMenList, data: formData);
      return serviceMenAPIFromJson(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return <ServiceMen>[];
    }
  }

  static Future<List<ServiceMen>> fetchServiceProviderWthNumber(
      String serviceId) async {
    try {
      final _prefs = await SharedPreferences.getInstance();
      var postData = {
        'seller_id': await _prefs.getString('userId') ?? '',
        "phone": serviceId
      };
      var formData = FormData.fromMap(postData);
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.fetchServiceProviderWthNumber, data: formData);
      return serviceMenAPIFromJson(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return <ServiceMen>[];
    }
  }

  static Future placeOrder(Products data, String address, String grandTotal,
      String cash_on_delivery) async {
    try {
      final _prefs = await SharedPreferences.getInstance();
      var postData = {
        'user_email': await _prefs.getString('userEmail') ?? '',
        "seller_id": data.sellerId,
        "name": data.name,
        "user address": address,
        'price': grandTotal,
        'product_image': data.imgurl,
        'cash_on_delivery': cash_on_delivery
      };
      var formData = FormData.fromMap(postData);
      var response =
          await GetDio.getDio().post(ApiEndPoints.baseURL+ApiEndPoints.placeOrder, data: formData);
      print(response);
      return jsonDecode(response.data);
    } catch (e) {
      print(e);
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return null;
    }
  }

  static Future updateProfileUser(postData) async {
    var formData = FormData.fromMap(postData);
    try {
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.update_profile, data: formData);
      print("response$response");
      print("responseee$response");
      return jsonDecode(response.data);
    } catch (e) {
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }
}
