import 'dart:convert';
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

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    final url = 'http://yourserver.com/path_to_your_php_script.php';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> ordersJson = json.decode(response.body);
        setState(() {
          _orders = ordersJson.map((json) => Order.fromJson(json)).toList();
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
          : _orders.isEmpty
          ? Center(child: Text('No orders found.'))
          : ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          final order = _orders[index];
          return Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              leading: Image.network(order.pdImageUrl),
              title: Text(order.productName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price: ${order.productPrice}'),
                  Text('Description: ${order.productDescription}'),
                  Text('Seller ID: ${order.sellerId}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
