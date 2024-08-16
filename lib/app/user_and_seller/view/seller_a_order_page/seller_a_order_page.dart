import 'dart:convert';

import 'package:ecommerce_int2/app/user_and_seller/model/orderDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SellerAOrders extends StatefulWidget {
  const SellerAOrders({super.key});

  @override
  State<SellerAOrders> createState() => _SellerAOrdersState();
}

class _SellerAOrdersState extends State<SellerAOrders> {
  String email = '';

//getting order data

  Future<List<OrderDetails>> orderData() async {
    List<OrderDetails> orderDataList = [];
    try {
      var res = await http.post(Uri.parse(
          "http://192.168.22.165/ecom/fetch_orders_seller.php?email=sar1@k.com"));
      if (res.statusCode == 200) {
        var responseOrderOfBody = jsonDecode(res.body);
        if (responseOrderOfBody['success'] == true) {
          (responseOrderOfBody['orderItemsRecords'] as List).forEach((element) {
            orderDataList.add(OrderDetails.fromJson(element));
          });
        }
      } else {
        Get.snackbar("Not connected", "Connection Error");
      }
    } catch (e) {
      Get.snackbar("Error", "Something Got Wrong");
      print(e);
    }
    return orderDataList;
  }

//  'http://localhost/ecom/fetch_orders_seller.php?email=sar1@k.com'
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Orders"),
        ),
        body: FutureBuilder(
          future: orderData(),
          builder: (context, AsyncSnapshot<List<OrderDetails>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null) {
              return Center(
                child: Text("No Order Found"),
              );
            }
            if (snapshot.data!.length > 0) {
              return Container(
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      OrderDetails eachOrderDataDetails = snapshot.data![index];

                      return eachOrderDataDetails.driver_status == '0'
                          ? Text("Your Order Is Not Accepted")
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.amber,
                                ),
                                child: Column(
                                  children: [
                                    Text("Your Accepted Orders By Driver"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(eachOrderDataDetails.user),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(eachOrderDataDetails.totalAmount),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        eachOrderDataDetails.cash_on_delivery ==
                                                1
                                            ? "Cash On Delivery"
                                            : "ONline"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(eachOrderDataDetails.deliveryDate),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(eachOrderDataDetails.productName),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(eachOrderDataDetails.sellerPhone),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(eachOrderDataDetails.userPhone),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(eachOrderDataDetails.shopAddress),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(eachOrderDataDetails.userAddress),
                                  ],
                                ),
                              ),
                            );
                    }),
              );
            } else {
              Center(
                child: Text("No Data"),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
