import 'dart:convert';

import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class TermsUse extends StatefulWidget {
  const TermsUse({super.key});

  @override
  State<TermsUse> createState() => _TermsUseState();
}

class _TermsUseState extends State<TermsUse> {
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
        termText = existingTerms['terms_of_use'] ?? '';
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
          'Terms of Use',
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
