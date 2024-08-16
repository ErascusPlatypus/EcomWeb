// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:ecommerce_int2/app/user_and_seller/controller/userProductController.dart';

import 'package:ecommerce_int2/app/user_and_seller/model/sell_item_data.dart';
import 'package:ecommerce_int2/helper/base.dart';

import 'package:flutter/material.dart';
import '../../../../shared/widgets/InputDecorations.dart';

import '../profile_page/profile_page_seller.dart';
import 'marketPlacePage.dart';

class SellProductUser extends StatefulWidget {
  static const routeName = "/sellProductUser";

  @override
  _SellProductUserState createState() => _SellProductUserState();
}

class _SellProductUserState extends State<SellProductUser> {
  String? category = "none";
  String deliveryType = "By App";
  String imgurl = "", name = "", description = "";
  double price = 0.0;
  String status = '';
  String hintText = "Select Category";

  //TextController to read text entered in text field
  var name1 = new TextEditingController();
  var description1 = new TextEditingController();
  var price1 = new TextEditingController();
  var imgurl1 = new TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    name1.dispose();
    description1.dispose();
    price1.dispose();
    imgurl1.dispose();
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
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Sell Product'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login1.jpg'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              FutureBuilder(
                future: UserController.fetchAllCategory(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  if (snapshot.hasData) {
                    var count = snapshot.data.length - 1;
                    List<Category1> itemlist = [];
                    List<String> itemlist2 = [];
                    List<String> deliverTYpe = ['Own', '3rd Party', 'By App'];
                    for (var i = 0; i <= count; i++) {
                      itemlist.add(snapshot.data[i]);
                      itemlist2.add(itemlist[i].category);
                    }
                    print(itemlist2);
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(top: 2),
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
                                      controller: name1,
                                      keyboardType: TextInputType.text,
                                      decoration: buildInputDecoration(
                                          Icons.add_box, "Product Name"),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter Name';
                                        }
                                        return null;
                                      },
                                      onSaved: (String? value) {
                                        name = value!;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 15, left: 10, right: 10),
                                    child: TextFormField(
                                      controller: description1,
                                      keyboardType: TextInputType.text,
                                      decoration: buildInputDecoration(
                                          Icons.book, "Description"),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter description';
                                        }
                                        return null;
                                      },
                                      onSaved: (String? value) {
                                        description = value!;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 15, left: 10, right: 10),
                                    child: TextFormField(
                                      controller: price1,
                                      keyboardType: TextInputType.number,
                                      decoration: buildInputDecoration(
                                          Icons.money, "Price"),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter price ';
                                        }
                                        return null;
                                      },
                                      onSaved: (String? value) {
                                        price = value as double;
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
                                      hint: Text(hintText),
                                      dropdownColor: Colors.blue[100],
                                      elevation: 5,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.blue))),
                                      items:
                                          itemlist2.map(buildMenuItem).toList(),
                                      onChanged: (value) => setState(() {
                                        category = value;
                                        hintText = value as String;
                                      }),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      hint: Text(deliveryType),
                                      dropdownColor: Colors.blue[100],
                                      elevation: 5,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.blue))),
                                      items: deliverTYpe
                                          .map(buildMenuItem)
                                          .toList(),
                                      onChanged: (value) => setState(() {
                                        deliveryType = value!;
                                      }),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 15, left: 10, right: 10),
                                    child: TextFormField(
                                      controller: imgurl1,
                                      keyboardType: TextInputType.text,
                                      decoration: buildInputDecoration(
                                          Icons.link, "Image Link"),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter Image Link';
                                        }
                                        return null;
                                      },
                                      onSaved: (String? value) {
                                        imgurl = value!;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    height: 50,
                                    child: RaisedButton(
                                      color: Colors.blue[800],
                                      onPressed: () {
                                        if (_formkey.currentState!.validate()) {
                                          var postData = {
                                            'imageurl': imgurl1.text,
                                            'name': name1.text,
                                            'description': description1.text,
                                            'price': price1.text,
                                            'category': category,
                                            'deliver': deliveryType,
                                            'email': email,
                                          };
                                          UserProductController.sellItemNow(
                                                  email: email,
                                                  postData: postData)
                                              .then((value) {
                                            if (value == "success") {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    Future.delayed(
                                                        Duration(seconds: 2),
                                                        () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              MarketPlaceProducts
                                                                  .routeName,
                                                              arguments: email);
                                                    });
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Product Added!'),
                                                    );
                                                  });
                                            } else if (value == "restriced") {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    Future.delayed(
                                                        Duration(seconds: 3),
                                                        () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              ProfilePageSeller
                                                                  .routeName,
                                                              arguments: email);
                                                    });
                                                    return AlertDialog(
                                                      title: Text(
                                                          'You are restricted!'),
                                                    );
                                                  });
                                            }
                                          });
                                          return;
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          side: BorderSide(
                                              color: Colors.blue, width: 2)),
                                      textColor: Colors.black,
                                      child: Text(
                                        "Sell Item",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formkey.currentState!.validate()) {
                                          var postData = {
                                            'imageurl': imgurl1.text,
                                            'name': name1.text,
                                            'description': description1.text,
                                            'price': price1.text,
                                            'category': category,
                                            'deliver': deliveryType,
                                            'email': email,
                                          };
                                          UserProductController.sellItemNow(
                                                  email: email,
                                                  postData: postData)
                                              .then((value) {
                                            if (value == "success") {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    Future.delayed(
                                                        Duration(seconds: 2),
                                                        () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Product Added!'),
                                                    );
                                                  });
                                              imgurl1.clear();
                                              name1.clear();
                                              description1.clear();
                                              price1.clear();
                                              email.clear();
                                            } else if (value == "restriced") {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    Future.delayed(
                                                        Duration(seconds: 3),
                                                        () {
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              ProfilePageSeller
                                                                  .routeName,
                                                              arguments: email);
                                                    });
                                                    return AlertDialog(
                                                      title: Text(
                                                          'You are restricted!'),
                                                    );
                                                  });
                                            }
                                          });
                                          return;
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white, backgroundColor: Colors
                                            .blue, // Set the text color
                                      ),
                                      child: Text('Sell Item'),
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
                    );
                  }
                  return CircularProgressIndicator.adaptive();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  RaisedButton(
      {Color? color,
      required Null Function() onPressed,
      required RoundedRectangleBorder shape,
      required Color textColor,
      required Text child}) {}
}
