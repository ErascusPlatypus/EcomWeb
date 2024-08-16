
import 'package:dio/dio.dart';
import 'package:ecommerce_int2/constants/AppStrings.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../constants/apiEndPoints.dart';
import '../../../helper/ApiHandler.dart';
import '../../user_and_seller/model/orderDetails.dart';

class DeliveryController{

  static Future updateLocation(double lat, double lng, String email) async {
    var postData = {'lat': lat.toString(), 'lng': lng.toString(), 'email': email};
    var formData = FormData.fromMap(postData);
    try{
      await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.update_location_driver,data: formData);
    }
    catch(e){
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }

  }


  static Future<List<OrderDetails>?> postEmail(String email) async {
    var postData = {
      'email': email,
    };
    var formData = FormData.fromMap(postData);
    try{
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.fetch_order,data: formData);
      return orderDetailsFromJson(response.data);
    }
    catch(e){
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return <OrderDetails>[];
    }

  }
}