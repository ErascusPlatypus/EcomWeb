import 'package:ecommerce_int2/app/user_and_seller/model/id.dart';
import 'package:get/get.dart';

import 'user_preference.dart';

class CurrentUser extends GetxController {
  Rx<Id> _currentUser = Id(name: "", value: '0').obs;

  Id get user => _currentUser.value;

  getUserInfo() async {
    Id? getUserInfoFromLocalStorage = await RememberUserPrefs.readUserInfo();
    _currentUser.value = getUserInfoFromLocalStorage!;
  }
}
