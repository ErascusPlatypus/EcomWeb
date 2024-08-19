import 'dart:convert';

import 'package:ecommerce_int2/app/user_and_seller/controller/userAuthController.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/seller_dashboard/seller_dashboard.dart';
import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/auth/registration-page-owner.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/apiEndPoints.dart';
import '../../../../main.dart';

import '../../../../shared/widgets/diffUserText.dart';
import '../profile_page/profile_page_seller.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WelcomeBackPageOwner extends StatefulWidget {
  static const routeName = '/login-seller';

  @override
  _WelcomeBackPageOwnerState createState() => _WelcomeBackPageOwnerState();
}

class _WelcomeBackPageOwnerState extends State<WelcomeBackPageOwner> {
  TextEditingController email = TextEditingController(text: 'sar1@k.com');
  TextEditingController password = TextEditingController(text: '12345678');

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget forgotPassword = Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'New Seller? ',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(255, 255, 255, 0.5),
              fontSize: 14.0,
            ),
          ),
          InkWell(
            onTap: () {
              launch(context, RegisterPageOwner.routeName);
            },
            child: Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );

    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image: AssetImage('assets/minions.jpg'),
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Welcome Back,',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'OpenSans',
                        color: Colors.orangeAccent,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Login to your account using \nyour account number',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.yellow[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.black12),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_outlined, color: Colors.yellow[700]),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.yellow[700]),
                              hintText: 'example@gmail.com',
                              hintStyle: TextStyle(color: Colors.black12),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow[700]!, width: 2.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          TextField(
                            controller: password,
                            obscureText: true,
                            style: TextStyle(color: Colors.black12),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock, color: Colors.yellow[700]),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.yellow[700]),
                              hintText: '12345678',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow[700]!, width: 2.0),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.remove_red_eye_rounded, color: Colors.yellow[700]),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () async {
                                await UserAuthController.userOwnerLogin(
                                    email: email.text, password: password.text)
                                    .then((value) async {
                                  if (value['auth']) {
                                    await UserAuthController.storeUserData(value['data']['id'],
                                        value['data']['shop_name'], value['data']['email'], 'seller');
                                    final _prefs = await SharedPreferences.getInstance();
                                    _prefs.setBool('isLoggedIn', true);
                                    _prefs.setString('userType', 'userOwnerLogin');
                                    _prefs.setString("userEmail", email.text);
                                    launch(context, SellerDashboard.routeName, email.text);
                                  } else {
                                    context.toast(value['msg']);
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 80.0),
                                decoration: BoxDecoration(
                                  color: Colors.yellow[700],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    'LOGIN (Seller)',
                                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text('Forgot Password?', style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'OpenSans', fontSize: 16.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            RegisterTextButton(
              mainText: 'New Seller? ',
              actionText: 'Register here',
              onTap: () => launch(context, WelcomeBackPageOwner.routeName),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  void userLogin() async {
    var url = ApiEndPoints.baseURL + ApiEndPoints.loginapiowner;

    var data = {
      "email": email.text,
      "password": password.text,
    };
    print(data);
    var response = await http.post(Uri.parse(url), body: data);
    print(response.body);
    var decodedResponse = jsonDecode(response.body);
    if (decodedResponse == "true") {
      launch(context, ProfilePageSeller.routeName, email.text);
    } else if (decodedResponse == "wrongPassword") {
      context.toast("Wrong password");
    } else if (decodedResponse == "noUser") {
      context.toast("User does not exist");
    }
  }
}
