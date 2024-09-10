import 'dart:convert' show base64Encode, jsonEncode, utf8;
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

import '../../model/products.dart';
import '../order_sucess/order_success.dart';

class PhonepePg {
  int amount;
  BuildContext context;
  Products product ;
  String? address ;
  String email ;

  PhonepePg({
    required this.email,
    required this.context,
    required this.amount,
    required this.product,
    this.address});

  String marchentId = "PGTESTPAYUAT86";
  String salt = "96434309-7796-489d-8924-ab56988a6076";
  int saltIndex = 1;
  String callbackURL = "https://webhook.site/cc612551-ca50-4afa-add6-5518741943a3";
  String apiEndPoint = "/pg/v1/pay";

  init() {
    PhonePePaymentSdk.init("SANDBOX", null, marchentId, true).then((val) {
      print('PhonePe SDK Initialized - $val');
      startTransaction();
    }).catchError((error) {
      print('PhonePe SDK error - $error');
      return <dynamic>{};
    });
  }

  startTransaction() {
    Map body = {
      "merchantId": marchentId,
      "merchantTransactionId": "sasa829292",
      "merchantUserId": "asas", // login
      "amount": amount * 100, // paisa
      "callbackUrl": callbackURL,
      "mobileNumber": "9876543210", // login
      "paymentInstrument": {"type": "PAY_PAGE"}
    };

    log(body.toString());

    // base64 encoding
    String bodyEncoded = base64Encode(utf8.encode(jsonEncode(body)));

    // Create the checksum using the body, API endpoint, and salt
    var byteCodes = utf8.encode(bodyEncoded + apiEndPoint + salt);
    String checksum = "${sha256.convert(byteCodes)}###$saltIndex";

    PhonePePaymentSdk.startTransaction(bodyEncoded, callbackURL, checksum, "")
        .then((success) {
      log("Payment response: ${success}");

      // Parse the result and check for success or failure
      if (success != null && success["status"] == "SUCCESS") {
        log("Payment successful");
        navigateToSuccessScreen();
      } else {
        log("Payment failed with status: ${success?["status"]}");
        showFailureMessage(success?["error"] ?? "Unknown error occurred.");
      }
    }).catchError((error) {
      log("Payment error: ${error}");
      showFailureMessage(error.toString());
    });
  }

// Function to display failure message
  void showFailureMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment failed: $message"))
    );
  }


  void navigateToSuccessScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => OrderSuccessScreen(email: email, product: product, address: address),
      ),
    );
  }



}