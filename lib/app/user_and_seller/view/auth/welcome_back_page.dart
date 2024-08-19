import 'package:ecommerce_int2/app/admin/view/auth/admin_login.dart';
import 'package:ecommerce_int2/app/delivery/view/auth/welcome_back_driver.dart';
import 'package:ecommerce_int2/app/user_and_seller/controller/userAuthController.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/auth/register_page.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/auth/welcome_back-page-owner.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/main/main_page.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/profile_page/forgot_password_page.dart';
import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:ecommerce_int2/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce_int2/shared/widgets/diffUserText.dart';

class WelcomeBackPage extends StatefulWidget {
  static const routeName = '/login';

  @override
  State<WelcomeBackPage> createState() => _WelcomeBackPageState();
}

class _WelcomeBackPageState extends State<WelcomeBackPage> {
  TextEditingController emailController = TextEditingController(text: 'example@email.com');
  TextEditingController passwordController = TextEditingController(text: '12345678');

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                Image(image: AssetImage('assets/minions.jpg'), height: size.height * 0.2,),
                SizedBox(height: 20.0),
                Text('Welcome Back,',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'OpenSans',
                      color: Colors.orangeAccent,
                    )
                      ),
                SizedBox(height: 10.0),
                Text('Login to your account using \nyour account number', style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.yellow[700],
                  fontWeight: FontWeight.w600,
                ),),
                SizedBox(height: 25.0),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline_outlined, color: Colors.yellow[700]),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.yellow[700]),
                          hintText: 'example@gmail.com',
                          //hintStyle: TextStyle(color: Colors.black54),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow[700]!, width: 2.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0,),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Colors.yellow[700]),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.yellow[700]),
                          hintText: '12345678',
                          hintStyle: TextStyle(color: Colors.black87),
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
                      const SizedBox(height: 20.0,),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () async {
                            await UserAuthController.userLogin(emailController.text, passwordController.text)
                                .then((value) async {
                              print(value);
                              if (value['auth']) {
                                await UserAuthController.storeUserData(value['data']['id'],
                                    value['data']['name'], value['data']['email'], 'customer',
                                    profile: value['data']['image_url']);
                                final _prefs = await SharedPreferences.getInstance();
                                _prefs.setBool('isLoggedIn', true);
                                launch(context, MainPage.routeName, emailController.text);
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
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
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
                      const SizedBox(height: 40.0,),
                      RegisterTextButton(
                          mainText: 'Admin? ', actionText: 'Login here', onTap: () => launch(context, AdminLoginPage.routeName)),
                      const SizedBox(height: 35.0,),
                      Row(
                        children: [
                          Expanded(
                            child: RegisterTextButton(
                                mainText: 'Seller? ', actionText: 'Login here', onTap: () => launch(context, WelcomeBackPageOwner.routeName)),
                          ),
                          //const SizedBox(height: 15.0,width: 20.0,),
                          Expanded(
                            child: RegisterTextButton(
                                mainText: 'Driver? ', actionText: 'Login here', onTap: () => launch(context, WelcomeBackPageDriver.routeName)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 35.0,),
                      RegisterTextButton(
                          mainText: 'Don\'t have an account ? ', actionText: 'Register here', onTap: () => launch(context, RegisterPage.routeName)),
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
}




