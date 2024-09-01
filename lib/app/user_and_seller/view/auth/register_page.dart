import 'dart:convert';
import 'package:ecommerce_int2/app/user_and_seller/controller/userAuthController.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/auth/utils/form_widget.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/auth/utils/login_header_widget.dart';
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
  TextEditingController phone = TextEditingController(); // Added controller

  String email1 = "", password1 = "";
  final formKey = GlobalKey<FormState>();
  bool? formIsValid;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    cmfPassword.dispose();
    code.dispose();
    name.dispose();
    phone.dispose(); // Dispose the new controller
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

    Widget registerButton = Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: mainButton.colors.first,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0),
            ),
            elevation: 5,
          ),
          onPressed: () async {
            setState(() {
              formIsValid = formKey.currentState?.validate();
            });
            if (formKey.currentState?.validate() == true) {
              await UserAuthController.RegisterUser(
                  name: name.text,
                  email: email.text,
                  password: password.text,
                  code: code.text,
                  phone: phone.text) // Pass phone number
                  .then((value) async {
                if (value != null) {
                  if (value["success"] == "1") {
                    name.clear();
                    email.clear();
                    password.clear();
                    cmfPassword.clear();
                    code.clear();
                    phone.clear(); // Clear phone number
                    final _prefs = await SharedPreferences.getInstance();
                    _prefs.setBool('isLoggedIn', true);
                    finish(context);
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(value["message"].toString())));
                }
              });
            }
          },
          child: Center(
            child: Text(
              "Register",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0),
            ),
          ),
        ),
      ),
    );

    Widget registerForm = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.8),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: Form(
        autovalidateMode: AutovalidateMode.disabled,
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                keyboardType: TextInputType.emailAddress,
                decoration: buildInputDecoration(Icons.email, "Email"),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Email';
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\\.[a-z]").hasMatch(value)) {
                    return 'Please enter a valid Email';
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
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: buildInputDecoration(Icons.lock, "Password"),
                validator: (String? value) {
                  if (value!.length < 6) {
                    return 'Please enter at least 6 characters.';
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
                decoration: buildInputDecoration(Icons.lock, "Confirm Password"),
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
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: buildInputDecoration(Icons.phone, "Phone Number"),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
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
                decoration: buildInputDecoration(Icons.text_fields, "Referral Code"),
                validator: (String? value) {
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            registerButton,
          ],
        ),
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              LoginHeaderWidget(),
              registerForm,
              socialRegister,
            ],
          ),
        ),
      ),
    );
  }
}
