import 'dart:convert';

import 'package:ecommerce_int2/app/user_and_seller/controller/userAuthController.dart';
import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:ecommerce_int2/shared/controllers/commonController.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../shared/widgets/InputDecorations.dart';
import '../../../../shared/widgets/custom_alert_dialog.dart';

class RegisterPageOwner extends StatefulWidget {
  //static const routeName = '/register-seller';
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

  String email1 = "", password1 = "";
  String? address;
  String? lng, lat;
  String location = "None";

  bool _isEmailValid = false;
  String? errorDisplay = null;

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
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SUBTITLE
    Widget subTitle = Padding(
      padding: const EdgeInsets.only(right: 56.0),
      child: Text(
        'Create your new account for future uses.',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    );

    // BUTTON
    Widget registerButton = InkWell(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          if (email.text.length <= 0) {
            123.log;
          }
          if (_isEmailValid) {
            // Do something with the email
            String eml = email.text;
            'Valid email: $eml'.log;
            registerUser(lat, lng, address);
          } else {
            'Invalid email'.log;
          }
        }

        //Navigator.of(context).push(MaterialPageRoute(builder: (_) => WelcomeBackPageOwner()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: 80,
        child: Center(
          child: new Text(
            "Register\n(Sellers)",
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
    );

    // POSITION
    Future<Position> _determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return Future.error('Location services are disabled.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      return await Geolocator.getCurrentPosition();
    }

    // ADDRESS
    Future<void> getAddressFromLatLong(Position position) async {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      print(placemarks);
      Placemark place = placemarks[0];
      address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      lat = position.latitude.toString();
      lng = position.longitude.toString();
      _showCustomAlertDialog(
          context, true, "Location fetch successful!", address!);
      setState(() {});
    }

    // SOCIAL
    Widget registerForm = Container(
      height: 485,
      child: Column(
        children: <Widget>[
          Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 32.0, right: 12.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: buildInputDecoration(
                          Icons.email,
                          "Email",
                          errorText: _isEmailValid ? null : errorDisplay,
                        ),
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
                        onFieldSubmitted: (value) {
                          if (value.isEmpty) {
                            errorDisplay = 'Please Enter Email';
                          }
                          return null;
                        },
                        onChanged: (input) {
                          if (input.length > 0) {
                            setState(() {
                              errorDisplay = 'Invalid email';
                              CommonController.validateEmail(
                                  email.text, (valid) => _isEmailValid = valid);
                            });
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        controller: phone,
                        keyboardType: TextInputType.text,
                        decoration: buildInputDecoration(Icons.phone, "Phone"),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Phone Number';
                          }
                          if (value.length > 12) {
                            return 'Please a valid Phone Number';
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
                          if (value!.isEmpty) {
                            return 'Please Enter a Password';
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
                        controller: shop,
                        keyboardType: TextInputType.text,
                        decoration:
                            buildInputDecoration(Icons.shop, "Shop Name"),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Shop Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Do you have GSTIN or not?"),
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
                    if (hasGst) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          controller: gst,
                          keyboardType: TextInputType.text,
                          decoration:
                              buildInputDecoration(Icons.shop, "GSTIN Number"),
                          validator: (String? value) {
                            //add validator
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "If GST needs to be claim enter GSTIN else GST amount will not be credited to you",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("I agree with Above GST Condition"),
                          Checkbox(
                            value: agreeGstTerms,
                            onChanged: (v) {
                              agreeGstTerms = v!;
                              setState(() {});
                            },
                          ),
                        ],
                      )
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                              "Are you a 3rd party delivery service provider?"),
                        ),
                        Switch(
                          value: isThirdParty,
                          onChanged: (value) {
                            setState(() {
                              isThirdParty = value;
                            });
                          },
                        ),
                      ],
                    ),
                    if (isThirdParty) ...[
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(
                            color: Colors.blue,
                            width: 1.5,
                          ),
                        ),
                        child: DropdownButton<String>(
                          underline: Container(),
                          padding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                          isExpanded: true,
                          hint: Text("Select Service Type"),
                          value: selectedServiceType,
                          items: serviceTypes.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedServiceType = newValue!;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          controller: addressController,
                          onChanged: (v) async {
                            try {
                              List<Location> loc = await locationFromAddress(
                                  addressController.text);

                              if (loc.isNotEmpty) {
                                List<Placemark> placemarks =
                                    await placemarkFromCoordinates(
                                        loc[0].latitude, loc[0].longitude);
                                print(placemarks);
                                searchLocations
                                    .clear(); // Clear the list before adding new data
                                placemarks.forEach((element) {
                                  searchLocations.add(
                                    {
                                      'lat': loc[0].latitude,
                                      'lng': loc[0].longitude,
                                      'address':
                                          '${element.street}, ${element.subLocality}, ${element.locality}, ${element.postalCode}, ${element.country}',
                                    },
                                  );
                                });
                                setState(() {});
                              } else {
                                searchLocations.clear();
                                setState(() {});
                              }
                            } catch (e) {
                              searchLocations.clear();
                              setState(() {});
                            }
                          },
                          keyboardType: TextInputType.text,
                          decoration: buildInputDecoration(
                              Icons.search, "Search Address"),
                        ),
                      ),
                      if (searchLocations.isNotEmpty)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: searchLocations.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  if (serviceLocations
                                      .contains(searchLocations[index])) {
                                    _showCustomAlertDialog(
                                        context,
                                        true,
                                        'Already Exists',
                                        'Address already added to list');
                                  } else {
                                    serviceLocations
                                        .add(searchLocations[index]);
                                    searchLocations.clear();
                                    addressController.clear();
                                    setState(() {});
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[300]!),
                                    ),
                                  ),
                                  child: Text(
                                    searchLocations[index]["address"],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      if (serviceLocations.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: serviceLocations.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(top: 8),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      serviceLocations[index]["address"],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      serviceLocations.remove(
                                        serviceLocations[index],
                                      );
                                      setState(() {});
                                    },
                                    child: Icon(Icons.close),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                    ],
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ElevatedButton(
                        child: Text(
                          "Get shop location".log,
                          style: TextStyle(fontSize: 17),
                        ),
                        onPressed: () async {
                          Position position = await _determinePosition();
                          location = position.latitude.toString();
                          getAddressFromLatLong(position);
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

    // SOCIAL
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
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Spacer(flex: 3),
                    Spacer(),
                    subTitle,
                    Spacer(flex: 2),
                    registerForm,
                    Spacer(flex: 2),
                    Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: socialRegister)
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
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future registerUser(String? lat, String? lng, String? address) async {
    print("RRRRRRRRRRRRRRRRRRRRRRRRR");
    if (hasGst && !agreeGstTerms) {
      _showCustomAlertDialog(
          context, false, null, 'Not Agreed GSTIN Terms and Conditions!');
    } else if (isThirdParty &&
        (selectedServiceType == null || serviceLocations.isEmpty)) {
      if (selectedServiceType == null || selectedServiceType == '') {
        print(selectedServiceType);
        _showCustomAlertDialog(
            context, false, 'Service Type', 'Select service type');
        return;
      }
      if (serviceLocations.isEmpty) {
        _showCustomAlertDialog(context, false, 'Service Address',
            'Add atleast one service address');
      }
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
        'is_third_party': isThirdParty ? '1' : '0',
        'service_type': isThirdParty ? selectedServiceType : null,
        'service_locations':
            isThirdParty ? json.encode(serviceLocations) : null,
      };

      var data = await UserAuthController.registerApiOwner(postData);
      if (data['success'] == "1") {
        _showCustomAlertDialog(
            context, true, 'Registration successful!', data['message']);
      } else {
        _showCustomAlertDialog(
            context, false, 'Registration failed!', data['message']);
      }
    }
  }
}

_showCustomAlertDialog(
    BuildContext context, bool isSuccess, String? title, String message) {
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
