// ignore_for_file: must_be_immutable, unused_local_variable

import 'dart:convert';

import 'package:ecommerce_int2/app/user_and_seller/model/liked_product.dart';
import 'package:ecommerce_int2/app/user_and_seller/model/products.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/product/product_page.dart';
import 'package:ecommerce_int2/constants/apiEndPoints.dart';
import 'package:ecommerce_int2/helper/app_properties.dart';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LikedProduct extends StatefulWidget {
  static const routeName = "/likedproduct";
  LikedProduct();
  // final String email;
  
  _LikedProductState createState() => _LikedProductState();
}

class _LikedProductState extends State<LikedProduct> {
  List<likedProduct> _products = [];
  String email ='';
  @override
  void initState() {
    super.initState();
    getSharedPreferences();
    
  }
   Future<void> getSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    email = prefs.getString('userEmail') ?? '';
    print("here");
    print(email);
    getProductDetails(email);
  }

  Future<void> getProductDetails(String email) async {
    // added new API endpoint - Dhanush
    String url = ApiEndPoints.baseURL+ApiEndPoints.get_liked_product;
    //end addition

    try {
      var response = await http.post(Uri.parse(url), body: {'email_id': email});
      print(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'success') {
          List<dynamic> productDetails = data['product_details'];
          List<likedProduct> fetchedProducts =
              [];
          for (var product in productDetails) {
            fetchedProducts.add(likedProduct
                .fromJson(product)); 
          }
          setState(() {
            _products =
                fetchedProducts;
          });
        } else {
          print('Error: ${data['message']}');
        }
      } else {
        print(
            'Failed to fetch product details. HTTP Error ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    Future<void> deleteLikedProduct(int pid, String email) async {
      final String url =
          ApiEndPoints.baseURL+ApiEndPoints.liked_product_delete;

      try {
        final response = await http.post(
          Uri.parse(url),
          body: {
            'pid': pid.toString(),
            'email_id': email,
          },
        );

        if (response.statusCode == 200) {
          print('Product deleted successfully');
        } else {
          print('Failed to delete product');
        }
      } catch (error) {
        print('Network error: $error');
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: darkGrey),
        title: Text(
          'Liked Products',
          style: TextStyle(
              color: darkGrey, fontWeight: FontWeight.w500, fontSize: 18.0),
        ),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductPage(email,
                          product: Products(
                              pid: _products[index].pid.toString(),
                              description: _products[index].description,
                              categoryId:
                                  _products[index].categoryId.toString(),
                              imgurl: _products[index].imageUrl,
                              name: _products[index].name,
                              price: _products[index].price.toString(),
                              gst: _products[index].gst.toString(),
                              sellerId:
                                  _products[index].sellerId.toString(),
                              sellerBoost:
                                  _products[index].sellerBoost.toString()))));
            },
            // leading: Image.network(_products[index].imageUrl),
            title: Text(_products[index].name),
            subtitle: Text(_products[index].description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteLikedProduct(_products[index].pid, email);
                    setState(() {
                      _products.removeAt(index);
                    });
                  },
                ),
                Text('\$${_products[index].price.toStringAsFixed(2)}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
