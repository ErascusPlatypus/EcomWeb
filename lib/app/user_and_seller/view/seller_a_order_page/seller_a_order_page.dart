import 'dart:convert';

import 'package:ecommerce_int2/app/user_and_seller/model/orderDetails.dart';
import 'package:ecommerce_int2/constants/apiEndPoints.dart';
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

  Future<List<OrderDetails>> orderData() async {
    List<OrderDetails> orderDataList = [];
    try {
      var res = await http.post(
        Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.fetch_orders_seller),
        body: {
          'email': 'sar1@k.com',
        },
      );
      if (res.statusCode == 200) {
        var responseOrderOfBody = jsonDecode(res.body);
        if (responseOrderOfBody['success'] == true) {
          (responseOrderOfBody['orderItemsRecords'] as List).forEach((element) {
            orderDataList.add(OrderDetails.fromJson(element));
          });
        } else {
          Get.snackbar("Error", "Failed to fetch orders");
        }
      } else {
        Get.snackbar("Error", "Connection Error");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      print(e);
    }
    return orderDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: FutureBuilder<List<OrderDetails>>(
        future: orderData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("No Orders Found"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              OrderDetails eachOrderDataDetails = snapshot.data![index];

              return eachOrderDataDetails.driver_status == '0'
                  ? ListTile(
                title: Text("Your Order Is Not Accepted"),
              )
                  : Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.amber,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Your Accepted Orders By Driver",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                        SizedBox(height: 10),
                        Text("User: ${eachOrderDataDetails.user}"),
                        SizedBox(height: 10),
                        Text("Total Amount: ${eachOrderDataDetails.totalAmount}"),
                        SizedBox(height: 10),
                        Text(eachOrderDataDetails.cash_on_delivery == 1
                            ? "Cash On Delivery"
                            : "Online"),
                        SizedBox(height: 10),
                        Text("Delivery Date: ${eachOrderDataDetails.deliveryDate}"),
                        SizedBox(height: 10),
                        Text("Product: ${eachOrderDataDetails.productName}"),
                        SizedBox(height: 10),
                        Text("Seller Phone: ${eachOrderDataDetails.sellerPhone}"),
                        SizedBox(height: 10),
                        Text("User Phone: ${eachOrderDataDetails.userPhone}"),
                        SizedBox(height: 10),
                        Text("Shop Address: ${eachOrderDataDetails.shopAddress}"),
                        SizedBox(height: 10),
                        Text("User Address: ${eachOrderDataDetails.userAddress}"),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
