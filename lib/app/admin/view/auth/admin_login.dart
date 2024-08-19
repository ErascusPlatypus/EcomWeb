// recreated login pages - Dhanush
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_int2/app/admin/controller/adminAuthController.dart';
import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:ecommerce_int2/main.dart';
import 'package:flutter/material.dart';

import '../profile_page/profile_page_admin.dart';

class AdminLoginPage extends StatefulWidget {
  static const routeName = '/login-admin';

  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();

  const AdminLoginPage();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  TextEditingController email = TextEditingController(text: 'sarthak@k.com');

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
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage('assets/minions.jpg'),
                  height: size.height * 0.2,
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
                          //hintText: 'example@gmail.com',
                          hintStyle: TextStyle(color: Colors.black12),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.yellow[700]!, width: 2.0),
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
                          //hintText: '12345678',
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
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 80.0),
                            backgroundColor: Colors.yellow[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () {
                            userLogin() ;
                          },
                          child: Text(
                            'LOGIN (Admin) ',
                            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0,),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {}, child: const Text('Forgot Password?', style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'OpenSans', fontSize: 16.0),),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void userLogin() async {
    var data = {
      "email": email.text,
      "password": password.text,
    };
    var formData = FormData.fromMap(data);
    var response = await AdminAuthController.adminUserLogin(formData);
    print("response");
    print(response);
    var decodedResponse = jsonDecode(response.data);

    // added
    // var decodedResponse = "true" ;

    if (decodedResponse == "true") {
      launch(context, ProfilePageAdmin.routeName, email.text);
    } else if (decodedResponse == "wrongPassword") {
      context.toast("Wrong password");
    } else if (decodedResponse == "noUser") {
      context.toast("User does not exist");
    }
  }
}
