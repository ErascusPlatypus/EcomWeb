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
import '../../../../shared/widgets/diffUserText.dart';
import '../../../user_and_seller/view/auth/welcome_back-page-owner.dart';
import '../../../user_and_seller/view/profile_page_content/order_request.dart';

class WelcomeBackPageDriver extends StatefulWidget {
  const WelcomeBackPageDriver();

  static const routeName = '/login-driver';

  @override
  _WelcomeBackPageDriverState createState() => _WelcomeBackPageDriverState();
}

class _WelcomeBackPageDriverState extends State<WelcomeBackPageDriver> {
  TextEditingController email = TextEditingController(text: 'driver1@gmail.com');

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
                    style: TextStyle(fontSize: 16.0, color: Colors.black12),
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        //hintText: "email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextField(
                    controller: password,
                    style: TextStyle(fontSize: 16.0, color: Colors.black12),
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
                            style: TextStyle(color: Colors.black54),
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
                                padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 80.0),
                                decoration: BoxDecoration(
                                  color: Colors.yellow[700],
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    'LOGIN (Driver)',
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
            SizedBox(height: 20,),
            RegisterTextButton(
              mainText: 'Seller? ',
              actionText: 'Login here',
              onTap: () => launch(context, WelcomeBackPageOwner.routeName)
            ),
            RegisterTextButton(
                mainText: 'User? ',
                actionText: 'Login Here',
                onTap: () => launch(context, WelcomeBackPage.routeName)
            ),
            const SizedBox(height: 20,)
          ],
        ),
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

    var decodedResponse = jsonDecode(response.body);

    if (decodedResponse == "true") {
      launch(context, OrderRequest.routeName, email.text);
    } else if (decodedResponse == "wrongPassword") {
      context.toast("Wrong password");
    } else if (decodedResponse == "noUser") {
      context.toast("Driver does not exist");
    }
  }
}
