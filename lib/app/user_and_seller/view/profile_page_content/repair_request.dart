import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../shared/widgets/InputDecorations.dart';

class RepairRequest extends StatefulWidget {
  static const routeName = "/RepairRequest";

  @override
  State<RepairRequest> createState() => _RepairRequestState();
}

class _RepairRequestState extends State<RepairRequest> {
  String address = "",
      phone = "",
      issue = "",
      state = "",
      city = "",
      locality = "",
      landmark = "";

  String? category = "none";

  List<String> itemlist2 = [
    "10 PM - 12 PM",
    "12 PM - 2 PM",
    "2 PM - 4 PM",
    "4 PM - 6 PM",
    "6 PM - 8 PM"
  ];

  //TextController to read text entered in text field
  var address1 = new TextEditingController();

  var phone1 = new TextEditingController();

  var issue1 = new TextEditingController();

  var state1 = new TextEditingController();

  var city1 = new TextEditingController();

  var locality1 = new TextEditingController();

  var landmark1 = new TextEditingController();

  var date = new TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  DateTime? _selectedDate;

  @override
  void dispose() {
    // TODO: implement dispose
    address1.dispose();
    phone1.dispose();
    issue1.dispose();
    state1.dispose();
    city1.dispose();
    locality1.dispose();
    landmark1.dispose();
    date.dispose();
    super.dispose();
  }

  Widget getDateRangePicker() {
    return Container(
      padding: EdgeInsets.all(16),
      width: 300, // Set the width of the dialog
      height: 400,
      child: SfDateRangePicker(
        onSubmit: (value) {
          setState(() {
            print('${_selectedDate}');
            Navigator.of(context).pop();
          });
        },
        onCancel: () {
          Navigator.of(context).pop();
        },
        monthViewSettings: DateRangePickerMonthViewSettings(
          viewHeaderStyle: DateRangePickerViewHeaderStyle(
            backgroundColor: Colors.blueAccent,
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        todayHighlightColor: Colors.red,
        monthCellStyle: DateRangePickerMonthCellStyle(
          cellDecoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
          todayTextStyle: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
          disabledDatesTextStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          ),
          blackoutDateTextStyle: TextStyle(
            color: Colors.black,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        yearCellStyle: DateRangePickerYearCellStyle(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
          todayTextStyle: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
          disabledDatesTextStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          ),
          leadingDatesTextStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          ),
          cellDecoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        selectionShape: DateRangePickerSelectionShape.circle,
        selectionColor: Colors.orange,
        selectionTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        showActionButtons: true,
        view: DateRangePickerView.month,
        backgroundColor: Colors.white,
        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
          // Handle the date selection change
          // print(args.value);
          _selectedDate = args.value;
        },
        selectionMode: DateRangePickerSelectionMode.single,
      ),
    );
  }

  Widget build(BuildContext context) {
    final arguments = context.extra as List;
    String email = arguments[0];
    String sellerId = arguments[1];
    String service = arguments[2];
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
        title: Text('Repair Request'),
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
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: TextFormField(
                            controller: issue1,
                            keyboardType: TextInputType.text,
                            decoration:
                                buildInputDecoration(Icons.settings, "Issue"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Issue';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              issue = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: TextFormField(
                            controller: address1,
                            keyboardType: TextInputType.text,
                            decoration:
                                buildInputDecoration(Icons.home, "Address"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Address';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              address = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: TextFormField(
                            controller: state1,
                            keyboardType: TextInputType.text,
                            decoration: buildInputDecoration(
                                Icons.location_city_rounded, "State"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter State';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              state = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: TextFormField(
                            controller: city1,
                            keyboardType: TextInputType.text,
                            decoration: buildInputDecoration(
                                Icons.location_city_outlined, "City"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter City';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              city = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: TextFormField(
                            controller: locality1,
                            keyboardType: TextInputType.text,
                            decoration: buildInputDecoration(
                                Icons.location_city_sharp, "Locality"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Locality';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              locality = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: TextFormField(
                            controller: landmark1,
                            keyboardType: TextInputType.text,
                            decoration: buildInputDecoration(
                                Icons.location_city, "Landmark"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Landmark';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              landmark = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: TextFormField(
                            controller: phone1,
                            keyboardType: TextInputType.text,
                            decoration: buildInputDecoration(
                                Icons.phone, "Phone Number"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Phone Number';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              phone = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15, left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              title: _selectedDate != null
                                  ? Text(
                                      DateFormat('dd-MM-yyyy')
                                          .format(_selectedDate!),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text('Select date'),
                              trailing: IconButton(
                                color: Colors.blue,
                                alignment: Alignment.centerRight,
                                icon: Icon(Icons.date_range_outlined),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                            child: getDateRangePicker());
                                      });
                                },
                              ),

                              //  keyboardType: TextInputType.text,

                              // Icons.date_range_outlined, "Date (DD-MM-YYYY)"),
                            ),
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
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        width: 1.5, color: Colors.blue))),
                            items: itemlist2.map(buildMenuItem).toList(),
                            onChanged: (value) =>
                                setState(() => category = value),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate() == true) {
                                confirmRequest(
                                    email, sellerId, service, context);

                                return;
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Colors.blue, // Set the text color
                            ),
                            child: Text('Confirm\nRequest'),
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

  Future confirmRequest(String email, String sellerId, String service,
      BuildContext context) async {
    var postData = {
      'email': email,
      'address': address1.text,
      'phone': phone1.text,
      'issue': issue1.text,
      'sellerId': sellerId,
      'service': service,
      'state': state1.text,
      'city': city1.text,
      'locality': locality1.text,
      'landmark': landmark1.text,
      'timeslot': category,
      'date': date.text,
    };
    var data = await UserController.confirmRepairRequest(postData);
    if (data == "success") {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop();
            });
            return AlertDialog(
              title: Text('Request Confirmed'),
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
