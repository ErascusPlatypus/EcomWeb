import 'dart:convert';
import 'package:ecommerce_int2/constants/apiEndPoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Orders.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Order> _orders = [];
  bool _isLoading = true;
  int _totalOrders = 0;
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    final url = ApiEndPoints.baseURL + ApiEndPoints.fetch_all_orders;
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> ordersJson = json.decode(response.body);
        print(response.body);
        setState(() {
          _orders = ordersJson.map((json) => Order.fromJson(json)).toList();
          _totalOrders = _orders.length;
          _totalPrice = _orders.fold(0.0, (sum, order) {
            try {
              return sum + double.parse(order.productPrice);
            } catch (e) {
              print('Error parsing price for order ${order.productName}: ${order.productPrice}');
              return sum;
            }
          });
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      // Handle errors here, e.g., show a message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Orders: $_totalOrders',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Total Price: ₹${_totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
          Expanded(
            child: _orders.isEmpty
                ? Center(child: Text('No orders found.'))
                : ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                final order = _orders[index];
                return Card(
                  margin: EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: SizedBox(width: 60, child: Image.network(order.pdImageUrl, fit: BoxFit.cover)),
                    title: Text(order.productName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: ${order.productPrice}'),
                        Text('Seller ID: ${order.sellerId}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
