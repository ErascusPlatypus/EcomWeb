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

  // Filter options
  String _selectedMonth = 'All';
  String _selectedYear = 'All';
  String _selectedSellerId = 'All';

  final List<String> _months = [
    'All',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final List<String> _years = ['All', '2024', '2023', '2022']; // Update the years as needed
  final List<String> _sellerIds = ['All']; // This will be populated dynamically

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
        setState(() {
          _orders = ordersJson.map((json) => Order.fromJson(json)).toList();
          _populateSellerIds();
          _applyFilters();
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

  void _populateSellerIds() {
    // Add unique seller IDs to the _sellerIds list
    final uniqueSellerIds = _orders.map((order) => order.sellerId).toSet().toList();
    _sellerIds.addAll(uniqueSellerIds);
  }

  void _applyFilters() {
    List<Order> filteredOrders = _orders;

    // Filter by year
    if (_selectedYear != 'All') {
      filteredOrders = filteredOrders.where((order) {
        return DateTime.parse(order.orderDate).year.toString() == _selectedYear;
      }).toList();
    }

    // Filter by month
    if (_selectedMonth != 'All') {
      filteredOrders = filteredOrders.where((order) {
        return DateTime.parse(order.orderDate).month == _months.indexOf(_selectedMonth);
      }).toList();
    }

    // Filter by seller ID
    if (_selectedSellerId != 'All') {
      filteredOrders = filteredOrders.where((order) {
        return order.sellerId == _selectedSellerId;
      }).toList();
    }

    setState(() {
      _orders = filteredOrders;
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
                  style: TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Total Price: ₹${_totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                _buildFilters(),
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
                    leading: SizedBox(
                        width: 60,
                        child: _buildImage(order.pdImageUrl)),
                    title: Text(order.productName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: ${order.productPrice}'),
                        Text('Seller ID: ${order.sellerId}'),
                        Text('Date: ${order.orderDate}'),
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

  Widget _buildFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Month and Year Filter Dropdowns
        Row(
          children: [
            DropdownButton<String>(
              value: _selectedMonth,
              items: _months.map((String month) {
                return DropdownMenuItem<String>(
                  value: month,
                  child: Text(month),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedMonth = newValue!;
                  _applyFilters();
                });
              },
            ),
            SizedBox(width: 16.0),
            DropdownButton<String>(
              value: _selectedYear,
              items: _years.map((String year) {
                return DropdownMenuItem<String>(
                  value: year,
                  child: Text(year),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedYear = newValue!;
                  _applyFilters();
                });
              },
            ),
          ],
        ),
        SizedBox(height: 16.0),
        // Seller ID Filter Dropdown
        DropdownButton<String>(
          value: _selectedSellerId,
          items: _sellerIds.map((String sellerId) {
            return DropdownMenuItem<String>(
              value: sellerId,
              child: Text(sellerId),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedSellerId = newValue!;
              _applyFilters();
            });
          },
        ),
      ],
    );
  }

  Widget _buildImage(String imageUrl) {
    if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
      return Image.network(imageUrl, fit: BoxFit.cover);
    } else {
      return Image.asset(imageUrl.replaceFirst('assets/', 'assets/'),
          fit: BoxFit.cover);
    }
  }
}
