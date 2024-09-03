import 'dart:convert';

import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class SellerPolicy extends StatefulWidget {
  const SellerPolicy({super.key});

  @override
  State<SellerPolicy> createState() => _SellerPolicyState();
}

class _SellerPolicyState extends State<SellerPolicy> {
  String termText = "";

  void initState() {
    super.initState();
    fetchExistingTerms();
  }

  Future<void> fetchExistingTerms() async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/term_policies_get.php/'));

    if (response.statusCode == 200) {
      Map<String, dynamic> existingTerms = json.decode(response.body);
      print(existingTerms);
      setState(() {
        termText = existingTerms['seller_policy'] ?? '';
      });
    } else {
      throw Exception('Failed to load existing terms');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Seller Policy',
          style: TextStyle(color: darkGrey),
        ),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 25, left: 20,right: 5),
              child: Text(
                termText,
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
