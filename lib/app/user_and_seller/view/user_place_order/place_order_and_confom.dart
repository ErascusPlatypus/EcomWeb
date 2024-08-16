import 'dart:convert';

import 'package:ecommerce_int2/app/user_and_seller/model/buy_now/buy_now.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/payment/payment_page.dart';
import 'package:ecommerce_int2/constants/apiEndPoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/products.dart';

class OrderConfirmationScreen extends StatefulWidget {
  final Products product;
  final email;
  OrderConfirmationScreen(this.email, {required this.product});

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  final _formKey = GlobalKey<FormState>();

  //this is getting data from the table
  Future<List<BuyNow>> getBuyNowData() async {
    List<BuyNow> buyNowDataList = [];
    try {
      var res = await http.post(Uri.parse(ApiEndPoints.baseURL+ApiEndPoints.fetch_buy_now_data));
      if (res.statusCode == 200) {
        var responseBodyOfBuyNowData = jsonDecode(res.body);
        if (responseBodyOfBuyNowData['success'] == true) {
          (responseBodyOfBuyNowData['buyNowRecordData'] as List)
              .forEach((eachRecord) {
            if (buyNowDataList[eachRecord] == widget.email) {
              buyNowDataList.add(BuyNow.fromJson(eachRecord));
            }
          });
        }
      } else {
        Dialog(
          child: Text("Please Check Your Internet"),
        );
      }
    } catch (e) {
      print(e.toString());
    }
    return buyNowDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm Your Order"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder(
            future: getBuyNowData(),
            builder: (context, AsyncSnapshot<List<BuyNow>> dataSnapShot) {
              if (dataSnapShot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (dataSnapShot.hasError) {
                return Text("No Data Found");
              }
              if (dataSnapShot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.sizeOf(context).height * .3,
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                widget.product.name,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Container(
                                    height: 150,
                                    child: Image.asset(
                                      widget.product.imgurl,
                                      fit: BoxFit.cover,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Price",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  widget.product.price,
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                null;
                              } else {
                                return "Please Filled The Form";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Please Enter Street",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            null;
                          } else {
                            return "Please Filled The Form";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Please Enter Flat Number/House Number",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            null;
                          } else {
                            return "Please Filled The Form";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Please Enter Postal Code",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              return null;
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return PaymentPage();
                                }),
                              );
                            }
                          },
                          child: Text(
                            "Continue",
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  ),
                );
              } else {
                Text("No Data");
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
