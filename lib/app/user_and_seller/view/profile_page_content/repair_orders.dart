import 'package:ecommerce_int2/app/user_and_seller/controller/userAuthController.dart';
import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/profile_page_content/MessageDialogBox.dart';
import 'package:ecommerce_int2/constants/colors.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:ecommerce_int2/shared/widgets/InputDecorations.dart';
import 'package:flutter/material.dart';
import '../../model/appointmentUserModel.dart';

class RepairOrders extends StatefulWidget {
  static const routeName = "/RepairOrders";

  @override
  State<RepairOrders> createState() => _RepairOrdersState();
}

class _RepairOrdersState extends State<RepairOrders> {
  var date = new TextEditingController();

  // final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String? category = "none";

  List<String> itemlist2 = [
    "10 PM - 12 PM",
    "12 PM - 2 PM",
    "2 PM - 4 PM",
    "4 PM - 6 PM",
    "6 PM - 8 PM"
  ];
  @override
  void dispose() {
    // TODO: implement dispose
    date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final email = context.extra;
    DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black)));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Repair orders'),
      ),
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: FutureBuilder(
                  future: UserController.getAppointmentsForService(email),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            AppointmentsUser appointments =
                                snapshot.data[index];

                            return Column(children: <Widget>[
                              ListTile(
                                title: Text(
                                  appointments.service,
                                  style: TextStyle(fontSize: 20),
                                ),
                                leading: Icon(
                                  Icons.people,
                                ),
                              ),
                              ListTile(
                                title: Text("User: ${appointments.user}"),
                              ),
                              ListTile(
                                title: Text("Issue: ${appointments.issue}"),
                              ),
                              ListTile(
                                title: Text("Address: ${appointments.address}"),
                              ),
                              ListTile(
                                title: Text("Date: ${appointments.date}"),
                              ),
                              ListTile(
                                title: Text("Time: ${appointments.time}"),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  if (appointments.serviceman_status == "1" &&
                                      appointments.repairTime.isEmpty)
                                    MaterialButton(
                                      color: AppColor.primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      onPressed: () async {
                                        await UserAuthController
                                                .completeRepairOrder(
                                                    repair_id: appointments.id)
                                            .then((value) {
                                          // setState(() {});

                                          if (value != null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  value["message"].toString(),
                                                ),
                                              ),
                                            );
                                          }
                                        });
                                      },
                                      child: Text("Complete"),
                                    )
                                  else if (appointments.repairTime.isEmpty)
                                    MaterialButton(
                                      color: AppColor.primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      onPressed: () async {
                                        await UserAuthController
                                                .acceptRepairOrder(
                                                    repair_id: appointments.id)
                                            .then((value) {
                                          // setState(() {});
                                          if (value != null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  value["message"].toString(),
                                                ),
                                              ),
                                            );
                                          }
                                        });
                                      },
                                      child: Text("Accept"),
                                    ),
                                  MaterialButton(
                                    color: AppColor.primary,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    onPressed: () => showMessageDialog(context,
                                        from: email, to: appointments.seller),
                                    child: Text("Message Seller"),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 15, left: 10, right: 10),
                                child: Text(
                                  "If you would like to change your repair order time, please select a different time-slot below!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Form(
                                // key: _formkey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 15, left: 10, right: 10),
                                      child: TextFormField(
                                        controller: date,
                                        keyboardType: TextInputType.text,
                                        decoration: buildInputDecoration(
                                            Icons.phone, "Date (DD-MM-YYYY)"),
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'Please Enter Date';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                        left: 10,
                                        right: 10,
                                      ),
                                      child: DropdownButtonFormField<String>(
                                        hint: Text("select Preffered Timeslot"),
                                        dropdownColor: Colors.blue[100],
                                        elevation: 5,
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                borderSide: BorderSide(
                                                    width: 1.5,
                                                    color: Colors.blue))),
                                        items: itemlist2
                                            .map(buildMenuItem)
                                            .toList(),
                                        onChanged: (value) =>
                                            setState(() => category = value),
                                      ),
                                    ),
                                    MaterialButton(
                                      color: AppColor.primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      onPressed: () {
                                        // if (_formkey.currentState!.validate() == true) {
                                        // confirmRequest(email, context);
                                        rescheduleRequest(email, context);

                                        return;
                                        // }
                                      },
                                      child: Text("Reschedule"),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                            ]);
                          });
                    } else {
                      Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 30,
                          ),
                          child: Text(
                            "No Pending Repair Orders!",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ));
                    }
                    return CircularProgressIndicator.adaptive();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future rescheduleRequest(String email, BuildContext context) async {
    var postData = {
      'email': email,
      'timeslot': category,
      'date': date.text,
    };
    var data = await UserController.rescheduleRepairRequest(postData);
    if (data == "success") {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop();
            });
            return AlertDialog(
              title: Text('Repair order has been rescheduled.'),
            );
          });
    }
  }
}
