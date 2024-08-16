import 'dart:convert';
import 'package:ecommerce_int2/constants/apiEndPoints.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditTermsPage extends StatefulWidget {
  @override
  _EditTermsPageState createState() => _EditTermsPageState();
}

class _EditTermsPageState extends State<EditTermsPage> {
  TextEditingController termsOfUseController = TextEditingController();
  TextEditingController privacyPolicyController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  TextEditingController sellerPolicyController = TextEditingController();
  TextEditingController returnPolicyController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    termsOfUseController.dispose();
    privacyPolicyController.dispose();
    licenseController.dispose();
    sellerPolicyController.dispose();
    returnPolicyController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchExistingTerms();
  }

  Future<void> fetchExistingTerms() async {
    final response = await http
        .get(Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.term_policies_get));

    if (response.statusCode == 200) {
      Map<String, dynamic> existingTerms = json.decode(response.body);
      print(existingTerms);
      setState(() {
        termsOfUseController.text = existingTerms['terms_of_use'] ?? '';
        privacyPolicyController.text = existingTerms['privacy_policy'] ?? '';
        licenseController.text = existingTerms['license'] ?? '';
        sellerPolicyController.text = existingTerms['seller_policy'] ?? '';
        returnPolicyController.text = existingTerms['return_policy'] ?? '';
      });
    } else {
      throw Exception('Failed to load existing terms');
    }
  }

  Future<void> saveOrUpdateTerms() async {
    // Prepare the data to be sent to the server
    Map<String, dynamic> termsData = {
      'terms_of_use': termsOfUseController.text,
      'privacy_policy': privacyPolicyController.text,
      'license': licenseController.text,
      'seller_policy': sellerPolicyController.text,
      'return_policy': returnPolicyController.text,
    };

    // Send a POST request to the server to save or update the terms
    print(jsonEncode(termsData));
    final response = await http.post(
      Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.term_policies_update),
      body: jsonEncode(termsData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Terms saved or updated successfully
      // You can show a success message or navigate back to the previous screen
      context.toast("term policies updated successfully");
    } else {
      throw Exception('Failed to save or update terms');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Terms'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: termsOfUseController,
              decoration: InputDecoration(labelText: 'Terms of Use'),
              maxLines: null,
            ),
            TextFormField(
              controller: privacyPolicyController,
              decoration: InputDecoration(labelText: 'Privacy Policy'),
              maxLines: null,
            ),
            TextFormField(
              controller: licenseController,
              decoration: InputDecoration(labelText: 'License'),
              maxLines: null,
            ),
            TextFormField(
              controller: sellerPolicyController,
              decoration: InputDecoration(labelText: 'Seller Policy'),
              maxLines: null,
            ),
            TextFormField(
              controller: returnPolicyController,
              decoration: InputDecoration(labelText: 'Return Policy'),
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: saveOrUpdateTerms,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
