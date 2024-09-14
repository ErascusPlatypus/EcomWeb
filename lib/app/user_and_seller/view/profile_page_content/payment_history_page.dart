import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/apiEndPoints.dart';

class PaymentHistoryScreen extends StatefulWidget {
  final String userId;  // Pass the user ID

  PaymentHistoryScreen({required this.userId});

  @override
  _PaymentHistoryScreenState createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  List<dynamic> _paymentHistory = [];

  @override
  void initState() {
    super.initState();
    _fetchPaymentHistory();
  }

  _fetchPaymentHistory() async {
    try {
      var res = await http.get(
          Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.payment_history_get + '?user_id=${widget.userId}')
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        if (data['status'] == 'success') {
          setState(() {
            _paymentHistory = data['data'];
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No payment history found.')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching payment history: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        title: Text(
          'Payment History',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _paymentHistory.isEmpty
          ? Center(child: Text('No payment history available'))
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _paymentHistory.length,
        itemBuilder: (context, index) {
          var payment = _paymentHistory[index];
          return Card(
            color: Colors.yellow[50],
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(payment['product_name'],
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Seller: ${payment['seller']}'),
                  Text('Shop: ${payment['shop_name']}'),
                  //Text('Order Date: ${payment['order_date']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
