import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/apiEndPoints.dart';

class HelpSupportPageUser extends StatefulWidget {
  @override
  _HelpSupportPageState createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPageUser> {
  String _contact = '';
  String _email = '';
  String _address = '';

  @override
  void initState() {
    super.initState();
    _fetchHelpSupportInfo();
  }

  Future<void> _fetchHelpSupportInfo() async {
    final url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.help_support_get);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _contact = data['contact'] ?? 'N/A';
          _email = data['email'] ?? 'N/A';
          _address = data['address'] ?? 'N/A';
        });
      } else {
        // Handle server error
        print('Failed to load Help & Support content.');
      }
    } catch (e) {
      // Handle network error
      print('Error loading Help & Support content: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              _contact,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Email:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              _email,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Address:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              _address,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
