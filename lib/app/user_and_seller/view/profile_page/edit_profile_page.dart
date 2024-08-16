import 'dart:convert';

import 'package:ecommerce_int2/app/user_and_seller/controller/userAuthController.dart';
import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:ecommerce_int2/main.dart';
import 'package:ecommerce_int2/shared/widgets/InputDecorations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  static String routeName = '/edit_profile';

  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {


  TextEditingController email = TextEditingController();


  TextEditingController name = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose

    email.dispose();
    name.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // serviceId = context.extra;
    return Scaffold(
      appBar: _appBar(context),
      body: _body(),
    );
  }

  Form _body() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _nameField(),
                _emailField(),
                const SizedBox(
                  height: 32,
                ),
                _registerButton(),
              ],
            ),
          ),
        ));
  }

  InkWell _registerButton() {
    return InkWell(
      // onTap: () async {
      //   if (_formKey.currentState?.validate() == true) {
      //     await UserAuthController.registerServiceEmployee(
      //         email: email.text,
      //         name: name.text,
      //         phone: phone.text,
      //       address: address.text, service_id: '',
      //         );
      //
      //   }
      //   //Navigator.of(context).push(MaterialPageRoute(builder: (_) => WelcomeBackPage()));
      // },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: 80,
        child: Center(
          child:  TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              final _prefs = await SharedPreferences.getInstance();
              updateProfileNow(int.parse(await _prefs.getString('userId') ?? ''));
            },
            child: Text('Update'),
          )
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
    );
  }


  Padding _emailField() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        controller: email,
        keyboardType: TextInputType.emailAddress,
        decoration: buildInputDecoration(Icons.email, "Email"),
        validator: (String? value) {
          if ((value ?? '').trim().isEmpty) {
            return 'Please enter your Email';
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value ?? '')) {
            return 'Please enter a valid Email';
          }
          return null;
        },
        onSaved: (String? value) {
          email = value! as TextEditingController;
        },
      ),
    );
  }

  Padding _nameField() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        controller: name,
        keyboardType: TextInputType.name,
        decoration: buildInputDecoration(Icons.person, "Name"),
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Please enter your Name';
          }

          return null;

        },
        onSaved: (String? value) {
          name = value! as TextEditingController;
        },
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(CupertinoIcons.back, size: 32, color: Colors.orange),
        onPressed: () {
          finish(context);
        },
      ),
      title: Text(
        "Edit Profile Page",
        style: TextStyle(
            fontSize: 22, fontWeight: FontWeight.w600, color: Colors.orange),
      ),
    );
  }

  Future updateProfileNow(int id) async {
    var postData = {
      'id': id,
      'name': name.text,
      'email': email.text,

    };
    var data = await UserController.updateProfileUser(postData);
    print("data$data");
    if (data == "done") {
      print(data);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Profile Updated'),
            );
          });
    }else{
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('something went wrong'),
            );
          });
    }
  }


// void fetchData() async {
//   final result = await UserController.getSellerServices();
//   setState(() {
//     _data = result;
//     _data.forEach((element) {
//       if (element.id == serviceId) {
//         _serviceType = element;
//       }
//     });
//   });
// }
}
