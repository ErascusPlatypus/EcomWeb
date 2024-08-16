import 'dart:convert';

import 'package:ecommerce_int2/app/user_and_seller/model/id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs {
  //save-remember User-info
  static Future<void> storeUserInfo(Id userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJsonData = jsonEncode(userInfo.toJson());
    await preferences.setString("currentUser", userJsonData);
  }

  //get-read User-info
  static Future<Id?> readUserInfo() async {
    Id? currentUserInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userInfo = preferences.getString("currentUser");
    if (userInfo != null) {
      Map<String, dynamic> userDataMap = jsonDecode(userInfo);
      currentUserInfo = Id.fromJson(userDataMap);
    }
    return currentUserInfo;
  }

  static Future<void> removeUserInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("currentUser");
  }
}
