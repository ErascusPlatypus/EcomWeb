import 'dart:convert';

import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/apiEndPoints.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController retypePassword = TextEditingController();
  bool passwordsMatch = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    currentPassword.dispose();
    newPassword.dispose();
    retypePassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    currentPassword.addListener(validatePasswords);
    newPassword.addListener(validatePasswords);
    retypePassword.addListener(validatePasswords);
  }

  void validatePasswords() {
    setState(() {
      passwordsMatch = newPassword.text == retypePassword.text;
      print(passwordsMatch);
    });
  }

  Future<void> UpdatePassword() async {
    final _prefs = await SharedPreferences.getInstance();
    Map<String, String> termsData = {
      'email': _prefs.getString("userEmail") ?? "",
      'currentPassword': currentPassword.text,
      'newPassword': newPassword.text,
    };

    // Send a POST request to the server to save or update the terms
    print(jsonEncode(termsData));

    // final response = await http.post(
    //   Uri.parse('http://192.168.20.3/ecom-php/ecom/change_password.php/'),
    //   body: jsonEncode(termsData),
    // );
    var uri = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.change_password);
    var request = http.MultipartRequest('POST', uri)
      // ..headers.addAll(headers) //if u have headers, basic auth, token bearer... Else remove line
      ..fields.addAll(termsData);
    var res = await request.send();
    final respStr = await res.stream.bytesToString();

    if (res.statusCode == 200) {
      // Terms saved or updated successfully
      // You can show a success message or navigate back to the previous screen
      print(respStr);
      context.toast("password updated successfully");
      currentPassword.clear();
      newPassword.clear();
      retypePassword.clear();
    } else {
      throw Exception('Failed to save or update terms');
    }

    return jsonDecode(respStr);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    Widget changePasswordButton = InkWell(
      onTap: () {
        if (_formkey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Processing Data')),
          );
          if (passwordsMatch) {
            UpdatePassword();
          } else {
            context.toast("Retype password not same ");
          }
        }
      },
      child: Container(
        height: 80,
        width: width / 1.5,
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
        child: Center(
          child: Text("Confirm Change",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Settings',
          style: TextStyle(color: darkGrey),
        ),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
          bottom: true,
          child: LayoutBuilder(
            builder: (b, constraints) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 48.0, top: 16.0),
                              child: Text(
                                'Change Password',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Text(
                                'Enter your current password',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: TextFormField(
                                  controller: currentPassword,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      hintText: 'Existing Password',
                                      hintStyle: TextStyle(fontSize: 12.0)),
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 24, bottom: 12.0),
                              child: Text(
                                'Enter new password',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: TextFormField(
                                controller: newPassword,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: passwordsMatch
                                            ? Colors.grey
                                            : Colors.red,
                                      ),
                                    ),
                                    hintText: 'New Password',
                                    hintStyle: TextStyle(fontSize: 12.0)),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 24, bottom: 12.0),
                              child: Text(
                                'Retype new password',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: TextFormField(
                                  controller: retypePassword,
                                  onChanged: (value) {},
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      print("not corrct");
                                      return 'Please re-enter password';
                                    }
                                    // print(password.text);
                                    // print(confirmpassword.text);
                                    if (value != newPassword.text) {
                                      return 'The password you entered is different';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: passwordsMatch
                                              ? Colors.grey
                                              : Colors.red,
                                        ),
                                      ),
                                      hintText: 'Retype Password',
                                      hintStyle: TextStyle(fontSize: 12.0)),
                                )),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 8.0,
                                bottom:
                                    bottomPadding != 20 ? 20 : bottomPadding),
                            width: width,
                            child: Center(child: changePasswordButton),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
