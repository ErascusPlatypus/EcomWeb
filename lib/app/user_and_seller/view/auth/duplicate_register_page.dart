import 'dart:convert';

import 'package:ecommerce_int2/app/user_and_seller/controller/userAuthController.dart';
import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:ecommerce_int2/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/apiEndPoints.dart';
import '../../../../shared/widgets/InputDecorations.dart';


class RegisterPage extends StatefulWidget {
  static const routeName = '/register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController cmfPassword = TextEditingController();

  TextEditingController code = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();


  String email1 = "", password1 = "";
  final formKey = GlobalKey<FormState>();
  bool? formIsValid;
  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();
    password.dispose();
    cmfPassword.dispose();
    code.dispose();
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget title = Text(
      'Glad To Meet You',
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
          'Create your new account for future uses.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ));

    Widget registerButton = Positioned(
      left: MediaQuery.of(context).size.width / 4,
      bottom: 40,
      child: InkWell(
        onTap: () async {
          setState(() {
            formIsValid = formKey.currentState?.validate();
          });
          if (formKey.currentState?.validate() == true)
            await UserAuthController.RegisterUser(
                name: name.text,
                email: email.text,
                password: password.text,
                code: code.text,
              phone: phone.text
            )
                .then((value) async {
              if (value != null) {
                if (value["success"] == "1") {
                  name.clear();
                  email.clear();
                  password.clear();
                  cmfPassword.clear();
                  code.clear();
                  final _prefs = await SharedPreferences.getInstance();
                  _prefs.setBool('isLoggedIn', true);
                  finish(context);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(value["message"].toString())));
              }
            });

          //Navigator.of(context).push(MaterialPageRoute(builder: (_) => WelcomeBackPage()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 80,
          child: Center(
            child: new Text(
              "Register",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0),
            ),
          ),
          decoration: BoxDecoration(
              gradient: mainButton,
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

    Widget registerForm = Container(
      height: formIsValid == false ? 600 : 500,
      child: Stack(
        children: <Widget>[
          Container(
            height: formIsValid == false ? 510 : 400,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 32.0, right: 12.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        controller: name,
                        keyboardType: TextInputType.text,
                        decoration: buildInputDecoration(Icons.person, "Name"),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        controller: email,
                        keyboardType: TextInputType.text,
                        decoration: buildInputDecoration(Icons.email, "Email"),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Email';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return 'Please a valid Email';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          email1 = value!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        controller: password,
                        keyboardType: TextInputType.text,
                        decoration:
                        buildInputDecoration(Icons.lock, "Password"),
                        validator: (String? value) {
                          if (value!.length < 6) {
                            return 'Please enter atleast 6 characters.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        controller: cmfPassword,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: buildInputDecoration(
                            Icons.lock, "Confirm Password"),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please re-enter password';
                          }

                          if (password.text != cmfPassword.text) {
                            return "Password does not match";
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        controller: code,
                        keyboardType: TextInputType.text,
                        decoration: buildInputDecoration(
                            Icons.text_fields, "Refferal Code"),
                        validator: (String? value) {
                          // if (value!.length != 6) {
                          //   return 'Please enter 6 characters.';
                          // }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          registerButton,
        ],
      ),
    );

    Widget socialRegister = Column(
      children: <Widget>[
        Text(
          'You can sign in with',
          style: TextStyle(
              fontSize: 12.0, fontStyle: FontStyle.italic, color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.find_replace),
              onPressed: () {},
              color: Colors.white,
            ),
            IconButton(
                icon: Icon(Icons.find_replace),
                onPressed: () {},
                color: Colors.white),
          ],
        )
      ],
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
          Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(left: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Spacer(flex: 3),
                title,
                Spacer(),
                subTitle,
                Spacer(flex: 2),
                registerForm,
                Spacer(flex: 2),
                Padding(
                    padding: EdgeInsets.only(bottom: 10), child: socialRegister)
              ],
            ),
          ),
          Positioned(
            top: 30,
            left: 5,
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                GoRouter.of(context).pop(context);
              },
            ),
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future RegisterUser() async {
    var url = ApiEndPoints.baseURL + ApiEndPoints.registerapi;
    Map postData = {
      'email': email.text,
      'password': password.text,
      'code': code.text,
    };
    print(postData);
    var response = await http.post(Uri.parse(url), body: postData);
    var data = jsonDecode(response.body);
    code.clear();
    email.clear();
    password.clear();

    print(data);
  }
}
