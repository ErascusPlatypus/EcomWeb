import 'dart:convert';

import 'package:ecommerce_int2/app/delivery/controller/deliveryAuthController.dart';
import 'package:ecommerce_int2/app/delivery/view/seller_b/serviceman_page.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/auth/welcome_back_page.dart';
import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:ecommerce_int2/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/apiEndPoints.dart';
import '../../../user_and_seller/view/auth/welcome_back-page-owner.dart';
import '../../../user_and_seller/view/profile_page_content/order_request.dart';

class WelcomeBackPageDriver extends StatefulWidget {
  const WelcomeBackPageDriver();

  static const routeName = '/login-driver';

  @override
  _WelcomeBackPageDriverState createState() => _WelcomeBackPageDriverState();
}

class _WelcomeBackPageDriverState extends State<WelcomeBackPageDriver> {
  TextEditingController email = TextEditingController(text: 'driver2@k.com');

  TextEditingController password = TextEditingController(text: '12345678');

  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget welcomeBack = Text(
      'Welcome Back,',
      style: TextStyle(
          color: Colors.white,
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
          shadows: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ]),
    );

    Widget subTitle = Padding(
        padding: const EdgeInsets.only(right: 56.0),
        child: Text(
          'Login to your account using\nMobile number',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));
//login as a service man
    Widget loginButton = Positioned(
      left: MediaQuery.of(context).size.width / 4,
      bottom: 40,
      child: InkWell(
        onTap: () {
          DeliveryAuthController.driverLogin(
              email: email.text, password: password.text)
              .then((value) async {
            if (value['auth'] == true) {
              final _prefs = await SharedPreferences.getInstance();
              _prefs.setString('userEmail', email.text);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ServicemanPage();
              }));
              // launch(context, RepairOrders.routeName, email.text);
            } else if (value['auth'] == false) {
              context.toast("Wrong email or password");
            }
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 1.65,
          height: 80,
          child: Center(
            child: new Text(
              "Log In (Service Man)",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0),
            ),
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(236, 60, 3, 1),
                    Color.fromRGBO(234, 60, 3, 1),
                    Color.fromRGBO(216, 78, 16, 1),
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                )
              ],
              borderRadius: BorderRadius.circular(9.0)),
        ),
      ),
    );

    Widget loginForm = Container(
      height: 240,
      child: Stack(children: <Widget>[
        Container(
          height: 160,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 32.0, right: 12.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: email,
                    style: TextStyle(fontSize: 16.0),
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: "email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: password,
                    style: TextStyle(fontSize: 16.0),
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
        loginButton,
      ]),
    );
    Widget loginSeller = Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child:
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Text(
          'Seller? ',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Color.fromRGBO(255, 255, 255, 0.5),
            fontSize: 14.0,
          ),
        ),
        InkWell(
          onTap: () {
            // Navigator.pushNamed(context, 'login-seller');
            launch(context, WelcomeBackPageOwner.routeName);
            //launch(context, LoginSe)
          },
          child: Text(
            'Login Here',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
      ]),
    );
    Widget loginUser = Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'User? ',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(255, 255, 255, 0.5),
              fontSize: 14.0,
            ),
          ),
          InkWell(
            onTap: () {
              launch(context, WelcomeBackPage.routeName);
            },
            child: Text(
              'Login Here',
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(
              color: transparentYellow,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(flex: 3),
                welcomeBack,
                Spacer(),
                subTitle,
                Spacer(flex: 2),
                loginForm,
                loginSeller,
                loginUser,
              ],
            ),
          )
        ],
      ),
    );
  }

  void userLogin() async {
    var url = ApiEndPoints.baseURL + ApiEndPoints.logindriver;

    var data = {
      "email": email.text,
      "password": password.text,
    };
    //print(data);

    var response = await http.post(Uri.parse(url), body: data);
    print(response.body);
    var deccodedResponse = jsonDecode(response.body);

    //print(deccodedResponse);
    if (deccodedResponse == "true") {
      launch(context, OrderRequest.routeName, email.text);
    } else if (deccodedResponse == "wrongPassword") {
      context.toast("Wrong password");
    } else if (deccodedResponse == "noUser") {
      context.toast("Driver does not exist");
    }
  }
}
