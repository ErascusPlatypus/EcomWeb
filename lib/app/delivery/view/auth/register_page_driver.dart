import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/apiEndPoints.dart';
import '../../../../shared/widgets/diffUserText.dart';

class RegisterPageServiceMan extends StatefulWidget {
  static const routeName = '/register-service-man';

  @override
  _RegisterPageServiceManState createState() => _RegisterPageServiceManState();
}

class _RegisterPageServiceManState extends State<RegisterPageServiceMan> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String? selectedServiceType;

  @override
  void dispose() {
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> registerServiceMan() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    var url = ApiEndPoints.baseURL + ApiEndPoints.register_driver;
    var data = {
      "email": emailController.text,
      "mobile": mobileController.text,
      "password": passwordController.text,
      "service_type": selectedServiceType ?? '', // Ensure a non-null value
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        body: data,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
        },
      );

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(utf8.decode(response.bodyBytes));

        if (decodedResponse['status'] == 'success') {
          final _prefs = await SharedPreferences.getInstance();
          await _prefs.setString('userEmail', emailController.text);
          Navigator.pushNamed(context, '/service-man-dashboard');
        } else {
          print('Registration failed: ${decodedResponse['message']}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Registration failed: ${decodedResponse['message']}")),
          );
        }
      } else {
        print('Server error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Server error: ${response.statusCode}")),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/minions.jpg',
                  height: MediaQuery.of(context).size.height * 0.2,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20.0),
                Text(
                  'Create Account,',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'OpenSans',
                    color: Colors.orangeAccent,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Sign up as a serviceman',
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
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.black54),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined, color: Colors.yellow[700]),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black54),
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
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: Colors.black54),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone, color: Colors.yellow[700]),
                          labelText: 'Mobile Number',
                          labelStyle: TextStyle(color: Colors.black54),
                          hintText: '1234567890',
                          hintStyle: TextStyle(color: Colors.black12),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow[700]!, width: 2.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: TextStyle(color: Colors.black54),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.yellow[700]),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.black54),
                          hintText: '••••••••',
                          hintStyle: TextStyle(color: Colors.black12),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow[700]!, width: 2.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        controller: confirmPasswordController,
                        obscureText: true,
                        style: TextStyle(color: Colors.black54),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.yellow[700]),
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(color: Colors.black54),
                          hintText: '••••••••',
                          hintStyle: TextStyle(color: Colors.black12),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow[700]!, width: 2.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      DropdownButtonFormField<String>(
                        value: selectedServiceType,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedServiceType = newValue;
                          });
                        },
                        items: <String>['Electrician', 'Carpenter', 'Plumber']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.build, color: Colors.yellow[700]),
                          labelText: 'Service Type',
                          labelStyle: TextStyle(color: Colors.black54),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow[700]!, width: 2.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: registerServiceMan,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 80.0),
                            decoration: BoxDecoration(
                              color: Colors.yellow[700],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                'REGISTER',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                RegisterTextButton(
                  mainText: 'Already have an account? ',
                  actionText: 'Login here',
                  onTap: () => Navigator.pushNamed(context, '/login-driver'),
                ),
                const SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
