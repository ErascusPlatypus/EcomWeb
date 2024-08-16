import 'package:ecommerce_int2/app/admin/controller/adminController.dart';
import 'package:ecommerce_int2/app/admin/view/profile_page/extra_charges_admin.dart';
import 'package:flutter/material.dart';
import '../../../../shared/widgets/InputDecorations.dart';


// ignore: must_be_immutable
class ChangeCharges extends StatelessWidget {
  //TextController to read text entered in text field
  var service = new TextEditingController();

  var transFee = new TextEditingController();

  Future confirmRequest(BuildContext context) async {
    Map postData = {
      'serviceC': service.text,
      'trans': transFee.text,
    };
    var data = await AdminController.confirmRequest(postData);
    if (data == "success") {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => ExtraChargesAdmin()));
            });
            return AlertDialog(
              title: Text('Changes Confirmed'),
            );
          });
    }
    print(data);
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Change Charges'),
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
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
                          child: TextFormField(
                            controller: service,
                            keyboardType: TextInputType.number,
                            decoration: buildInputDecoration(
                                Icons.money_rounded, "Service Charge"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Service Charge';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: TextFormField(
                            controller: transFee,
                            keyboardType: TextInputType.number,
                            decoration: buildInputDecoration(
                                Icons.location_city_rounded, "Transaction Fee"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Transaction Fee';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: 200,
                          height: 80,
                          child: RaisedButton(
                            padding: EdgeInsets.all(16),
                            color: Colors.blue[800],
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                confirmRequest(context);
                                print("successful");

                                return;
                              } else {
                                print("UnSuccessfull");
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: BorderSide(color: Colors.blue, width: 2)),
                            textColor: Colors.white,
                            child: Text(
                              "Confirm\nChanges",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  RaisedButton({required EdgeInsets padding, Color? color, required Null Function() onPressed, required RoundedRectangleBorder shape, required Color textColor, required Text child}) {}
}
