
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/user_and_seller/model/getMessages.dart';
import '../../constants/AppStrings.dart';
import '../../constants/apiEndPoints.dart';

import '../../helper/ApiHandler.dart';

class CommonController {

  static validateEmail(String input, Function(bool _isEmailValid) callback) {
    if (input.length > 0) {
      callback(RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(input));
    } else {
      callback(true);
    }
  }

  static Future<List<GetMessages>> getMessages(String email) async {
    var postData = {
      'email': email,
    };
    var formData = FormData.fromMap(postData);
    try{
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.get_message, data: formData);
      return getMessagesFromJson(response.data);
    }catch(e){
      EasyLoading.showError(AppStrings.ApiErrorMessage);
      return <GetMessages>[];
    }

  }

  // TextStyle
  static TextStyle buttonPrimaryWhite = GoogleFonts.manrope(textStyle: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal));
  static TextStyle primaryTextWhite = GoogleFonts.manrope(textStyle: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal));
  static TextStyle primaryTitleBlack = GoogleFonts.manrope(textStyle: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold));
  static TextStyle primaryTitleWhite = GoogleFonts.manrope(textStyle: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold));

  static getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

}