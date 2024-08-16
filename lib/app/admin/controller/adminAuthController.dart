import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../constants/apiEndPoints.dart';
import '../../../constants/AppStrings.dart';
import '../../../helper/ApiHandler.dart';

class AdminAuthController{
  static adminUserLogin(data) async {
    try{
      var response = await GetDio.getDio()
          .post(ApiEndPoints.baseURL+ApiEndPoints.loginapiadmin, data: data);
      return response;
    }
    catch(e){
      EasyLoading.showError(AppStrings.ApiErrorMessage);
    }
  }
}