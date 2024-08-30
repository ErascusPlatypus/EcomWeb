import 'dart:convert';

import 'package:ecommerce_int2/app/user_and_seller/model/products.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/product/product_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/apiEndPoints.dart';
import '../profile_page_content/orderHistoryUser.dart';
import '../user_place_order/place_order_and_confirm.dart';

class OrderSuccessScreen extends StatelessWidget {
  static final String routeName = '/payment_success_screen';
  final Products product ;
  final String email ;
  final String address ;

  OrderSuccessScreen({required this.email, required this.product, required this.address});

  //buyNow
  _buyNow(BuildContext context) async {
    try {
      var res = await http.post(
        Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.insert_order),
        body: {
          "product_name": "Headphones LX32",
          "user": "example@example.com",
          "seller": "sar1@k.com",
          "shop_name": "SarShop",
          "user_phone": '9999999999',
          "seller_phone": '1111111111',
          "shop_lat": "98.321",
          "shop_lng": "77.432",
          "shop_address": "dfsf",
          "user_lat": "11.321",
          "user_lng": "99.325",
          "user_address": "address",
          "total_amount": "7999.99",
          "driver_id": "1",
          "driver_status": "0",
          "order_date": "24-08-2024",
          "delivery_date":"25-08-2024",
          "product_image": "assets/headphones1.png",
          "cash_on_delivery": "no",
        },
      );
      if (res.statusCode == 200) {
        var resBodyOfBuyNow = jsonDecode(res.body);
        if (resBodyOfBuyNow['success'] == true) {

          //print('SUUUUUUUUUUUUUUUUUUUUUUUUUCESSSSSSSSSSSSSSS');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) {
              return ProductPage(email, product: product);
            }),
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Something went wrong"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        elevation: 0.0,
        title: Text(
          'Payment Success',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_circle,
                color: Colors.yellow[700],
                size: 100,
              ),
              SizedBox(height: 16),
              Text(
                'Payment Successful!',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Thank you for your purchase. Your transaction has been completed successfully.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  _buyNow(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.yellow[700],
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Go to Home',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
