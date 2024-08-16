import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:ecommerce_int2/app/user_and_seller/controller/userProductController.dart';
import 'package:ecommerce_int2/app/user_and_seller/model/servicemen.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:ecommerce_int2/main.dart';
import 'package:ecommerce_int2/shared/controllers/commonController.dart';

import 'package:flutter/material.dart';
import '../../../../shared/widgets/InputDecorations.dart';

class RepairRequestAccept extends StatefulWidget {
  static const routeName = "/RepairRequestAccept";

  @override
  State<RepairRequestAccept> createState() => _RepairRequestAcceptState();
}

class _RepairRequestAcceptState extends State<RepairRequestAccept> {
  String phone = "";

  //TextController to read text entered in text field
  var name1 = new TextEditingController();
  var phone1 = new TextEditingController();

  String serviceman_email = '';

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    name1.dispose();
    phone1.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final arguments = context.extra as List;
    String user = arguments[0];
    String seller = arguments[1];
    String service = arguments[2];
    String rid = arguments[3];
    String address = arguments[4];
    String issue = arguments[5];
    String date = arguments[6];
    String time = arguments[7];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => finish(context),
        ),
        title: Text('Fix Appointment'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login1.jpg'), fit: BoxFit.cover),
        ),
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.only(top: 2),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: Text(
                        "You can choose from the service man options below!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        controller: name1,
                        keyboardType: TextInputType.text,
                        decoration: buildInputDecoration(
                            Icons.person, "Service Man Name"),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter service man name';
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: TextFormField(
                        controller: phone1,
                        keyboardType: TextInputType.text,
                        decoration:
                            buildInputDecoration(Icons.phone, "Mechanic Phone"),
                        validator: (String? value) {
                          if (value!.isEmpty || value.length < 10) {
                            return 'Please Enter Valid Phone Number';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {});
                        },
                        onSaved: (String? value) {
                          phone = value!;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          print("serviceman email is $serviceman_email");
                          if (_formkey.currentState!.validate()) {
                            confirmAppointment(user, seller, service, rid,
                                address, issue, date, time, context);

                            return;
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue, // Set the text color
                        ),
                        child: Text('Confirm\nAppointment'),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: FutureBuilder(
                          future: UserController.fetchServiceProviderWthNumber(
                              phone1.text),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                margin: EdgeInsets.only(top: 32),
                                child: snapshot.data.length > 0
                                    ? ListView.separated(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: snapshot.data.length,
                                        separatorBuilder: (_, i) {
                                          return SizedBox(width: 16);
                                        },
                                        itemBuilder: (_, i) {
                                          ServiceMen services =
                                              snapshot.data[i];
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                name1.text = services.name;
                                                phone1.text = services.phone;
                                                phone = services.phone;
                                                serviceman_email =
                                                    services.email;
                                              });
                                            },
                                            child: Column(children: <Widget>[
                                              ListTile(
                                                title: Text(
                                                  'Details',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.orangeAccent,
                                                  ),
                                                ),
                                                leading: Icon(
                                                  Icons.person,
                                                  color: Colors.orangeAccent,
                                                ),
                                              ),
                                              ListTile(
                                                title: Text(
                                                    "User: ${services.name}"),
                                              ),
                                              ListTile(
                                                title: Text(
                                                    "phone: ${services.phone}"),
                                              ),
                                              ListTile(
                                                title: Text(
                                                    "emil: ${services.email}"),
                                              ),
                                              Divider(),
                                            ]),
                                          );
                                        },
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Text(
                                          'No service men Found',
                                          style: CommonController
                                              .primaryTitleBlack
                                              .copyWith(
                                                  color: Colors.grey,
                                                  fontSize: 16),
                                        ),
                                      ),
                              );
                            } else {
                              return Text(
                                'No service men Found',
                                style: CommonController.primaryTitleBlack
                                    .copyWith(color: Colors.grey, fontSize: 16),
                              );
                            }
                          }),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future confirmAppointment(
      String user,
      String seller,
      String service,
      String rid,
      String address,
      String issue,
      String date,
      String time,
      BuildContext context) async {
    var postData = {
      'user': user,
      'seller': seller,
      'date': date,
      'time': time,
      'service': service,
      'address': address,
      'issue': issue,
      'rid': int.parse(rid),
      'phone': phone1.text,
      'serviceman_email': serviceman_email
    };
    // print(postData);
    var data = await UserProductController.confirmAppointment(postData);
    if (data == "success") {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 2), () {
              finish(context);
              finish(context);
            });
            return AlertDialog(
              title: Text('Appointment Confirmed'),
            );
          });
    }
  }

  RaisedButton(
      {Color? color,
      required Null Function() onPressed,
      required RoundedRectangleBorder shape,
      required Color textColor,
      required Text child}) {}
}
