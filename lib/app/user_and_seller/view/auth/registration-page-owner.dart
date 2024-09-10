import 'dart:convert';
import 'package:ecommerce_int2/app/user_and_seller/controller/userAuthController.dart';
import 'package:ecommerce_int2/shared/controllers/commonController.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../shared/widgets/InputDecorations.dart';
import '../../../../shared/widgets/custom_alert_dialog.dart';

class RegisterPageOwner extends StatefulWidget {
  static const routeName = "/RegisterSellerPage";

  @override
  _RegisterPageOwnerState createState() => _RegisterPageOwnerState();
}

class _RegisterPageOwnerState extends State<RegisterPageOwner> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cmfPassword = TextEditingController();
  TextEditingController shop = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController gst = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? address;
  String? lng, lat;
  String location = "None";

  bool _isEmailValid = false;
  String? errorDisplay;

  bool hasGst = false;
  bool agreeGstTerms = false;

  bool isThirdParty = false;
  List<Map<String, dynamic>> searchLocations = [];
  List<Map<String, dynamic>> serviceLocations = [];
  String? selectedServiceType;

  List<String> serviceTypes = [
    'Courier',
    'Parcel',
    'Movers & Packers (Local)',
    'Movers & Packers (National)'
  ];

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    cmfPassword.dispose();
    shop.dispose();
    phone.dispose();
    gst.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // BUTTON
    Widget registerButton = InkWell(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          if (_isEmailValid) {
            registerUser(lat, lng, address);
          }
        }
      },
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width / 2,
        height: 60,
        child: Center(
          child: Text(
            "Register\n(Sellers)",
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18.0),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.yellow[700],
          borderRadius: BorderRadius.circular(9.0),
        ),
      ),
    );

    // ADDRESS
    Future<void> getAddressFromLatLong(Position position) async {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      address =
      '${place.street}, ${place.subLocality}, ${place.locality}, ${place
          .postalCode}, ${place.country}';
      lat = position.latitude.toString();
      lng = position.longitude.toString();
      _showCustomAlertDialog(
          context, true, "Location fetch successful!", address!);
      setState(() {
        location = place.locality!;
      });
    }


    // REGISTER FORM
    Widget registerForm = Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: buildInputDecoration(
                Icons.email,
                "Email",
                errorText: _isEmailValid ? null : errorDisplay,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an email';
                }
                if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(
                    value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              onChanged: (input) {
                CommonController.validateEmail(
                    email.text, (valid) => _isEmailValid = valid);
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: phone,
              keyboardType: TextInputType.phone,
              decoration: buildInputDecoration(Icons.phone, "Phone"),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter phone number';
                }
                if (value.length > 12) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: password,
              keyboardType: TextInputType.text,
              decoration: buildInputDecoration(Icons.lock, "Password"),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: cmfPassword,
              obscureText: true,
              decoration: buildInputDecoration(Icons.lock, "Confirm Password"),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please re-enter password';
                }
                if (password.text != cmfPassword.text) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: shop,
              decoration: buildInputDecoration(Icons.shop, "Shop Name"),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter shop name';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Do you have GSTIN?"),
                Switch(
                  value: hasGst,
                  onChanged: (value) {
                    setState(() {
                      hasGst = value;
                    });
                  },
                ),
              ],
            ),
            if (hasGst)
              Column(
                children: [
                  TextFormField(
                    controller: gst,
                    decoration: buildInputDecoration(Icons.shop, "GSTIN"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter GSTIN';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("I agree with GST terms"),
                      Checkbox(
                        value: agreeGstTerms,
                        onChanged: (value) {
                          setState(() {
                            agreeGstTerms = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Position? position;
                try {
                  // Try to get the current position
                  position = await Geolocator.getCurrentPosition();
                } catch (e) {
                  // If the error indicates that permission was denied, set dummy location
                  if (e.toString().contains(
                      'User denied permissions to access the device\'s location')) {
                    position = Position(
                      latitude: 12.9716,
                      // Dummy latitude (e.g., Bengaluru)
                      longitude: 77.5946,
                      // Dummy longitude (e.g., Bengaluru)
                      timestamp: DateTime.now(),
                      altitude: 0.0,
                      accuracy: 0.0,
                      heading: 0.0,
                      speed: 0.0,
                      speedAccuracy: 0.0,
                      altitudeAccuracy: 0.0,
                      headingAccuracy: 0.0,
                    );
                    _showCustomAlertDialog(
                        context,
                        false,
                        'Location Permission Denied',
                        'Using a default location instead.'
                    );
                  } else {
                    // Handle other possible errors (e.g., services disabled)
                    _showCustomAlertDialog(
                        context, false, 'Error', 'Failed to get location.');
                    return;
                  }
                }

                // Proceed with address retrieval (real or dummy location)
                getAddressFromLatLong(position!);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700],
              ),
              child: Text("Get shop location"),
            )

          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Seller Registration"),
        backgroundColor: Colors.yellow[700],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              registerForm,
              SizedBox(height: 20),
              registerButton,
            ],
          ),
        ),
      ),
    );
  }

  Future registerUser(String? lat, String? lng, String? address) async {
    if (hasGst && !agreeGstTerms) {
      _showCustomAlertDialog(context, false, null, 'Not agreed to GST terms');
    } else if (location == "None") {
      _showCustomAlertDialog(context, false, null, 'No location selected!');
    } else {
      var postData = {
        'email': email.text,
        'password': password.text,
        'shop_name': shop.text,
        'lat': lat,
        'lng': lng,
        'address': address,
        'phone': phone.text,
        'gst': gst.text,
        'delivery_area': location,
        'isRestrict': 0,
        'is_third_party': 1,
        'service_type': 'None',
        'service_locations': 'None' // Adjust this as needed
      };

      try {
        var response = await UserAuthController.registerApiOwner(postData);

        // Check if the response is not null
        if (response != null && response.data != null) {
          var data = response.data;

          // Ensure that 'success' key exists in the response
          if (data['success'] != null) {
            if (data['success'] == "1") {
              _showCustomAlertDialog(
                  context, true, 'Registration successful', data['message']);
            } else {
              _showCustomAlertDialog(
                  context, false, 'Registration failed', data['message']);
            }
          } else {
            _showCustomAlertDialog(context, false, 'Unexpected response format',
                'Response did not contain "success" key.');
          }
        } else {
          _showCustomAlertDialog(context, false, 'Empty Response',
              'No data received from server.');
        }
      } catch (e) {
        // Handle Dio errors
        _showCustomAlertDialog(
            context, false, 'Error', 'Failed to register user: $e');
      }
    }
  }
}

  _showCustomAlertDialog(BuildContext context, bool isSuccess, String? title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        isSuccess: isSuccess,
        message: message,
        title: title,
      );
    },
  );
}
