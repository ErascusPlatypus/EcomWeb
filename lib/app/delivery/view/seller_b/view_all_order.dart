import 'dart:convert';

import 'package:ecommerce_int2/app/delivery/view/seller_b/update_order.dart';
import 'package:ecommerce_int2/app/user_and_seller/model/orderDetails.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/auth/welcome_back_page.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/seller_a_order_page/seller_a_order_page.dart';
import 'package:ecommerce_int2/constants/apiEndPoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ViewAllOrder extends StatefulWidget {
  const ViewAllOrder({super.key});
  @override
  State<ViewAllOrder> createState() => _ViewAllOrderState();
}

class _ViewAllOrderState extends State<ViewAllOrder> {
  final SellerAOrders sellerAOrders = SellerAOrders();
  String email = "sar1@k.com";

//getting order data

  Future<List<OrderDetails>> orderData() async {
    List<OrderDetails> orderDataList = [];
    try {
      var res = await http.post(
        Uri.parse(
            ApiEndPoints.baseURL + "fetch_orders_seller.php?email=$email"),
      );
      if (res.statusCode == 200) {
        var responseOrderOfBody = jsonDecode(res.body);
        print(responseOrderOfBody);
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

//show dialog confirmation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => WelcomeBackPage()));
              },
              icon: Icon(CupertinoIcons.backward)),
          title: Text("You Have To Deliver"),
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

                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.amber,
                            ),
                            child: Column(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return UpdateOrderByDriver(
                                            id: eachOrderDataDetails.id
                                                .toString(),
                                            driverStatus: eachOrderDataDetails
                                                .driver_status,
                                            sellerName:
                                                eachOrderDataDetails.seller,
                                            seller_phone: eachOrderDataDetails
                                                .sellerPhone,
                                            shop_address: eachOrderDataDetails
                                                .shopAddress,
                                            shop_name:
                                                eachOrderDataDetails.shopName,
                                            userName: eachOrderDataDetails.user,
                                            user_phone:
                                                eachOrderDataDetails.userPhone);
                                      }));
                                    },
                                    child: Text(
                                        eachOrderDataDetails.driver_status ==
                                                "0"
                                            ? "Please Confirm The orders"
                                            : "You are accepted the order")),
                                Text(eachOrderDataDetails.user),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(eachOrderDataDetails.shopAddress),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(eachOrderDataDetails.totalAmount),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(eachOrderDataDetails.userAddress),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(eachOrderDataDetails.userAddress),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Text("Your Delivery Status"),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(eachOrderDataDetails.driver_status ==
                                              "0"
                                          ? "Pending"
                                          : "Accepted\nThe Dispatch"),
                                    ],
                                  ),
                                ),
                              ],
                            )),
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
