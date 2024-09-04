import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../constants/apiEndPoints.dart';

class HelpSupportPage extends StatefulWidget {
  static const routeName = "/HelpSupportUser" ;

  @override
  _HelpSupportPageState createState() => _HelpSupportPageState();
}

class _HelpSupportPageState extends State<HelpSupportPage> {
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadHelpSupportInfo();
  }

  void _loadHelpSupportInfo() async {
    final url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.help_support_get);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _contactController.text = data['contact'] ?? '';
          _emailController.text = data['email'] ?? '';
          _addressController.text = data['address'] ?? '';
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

  void _saveHelpSupportInfo() async {
    final url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.help_support_update);
    final response = await http.post(
      url,
      body: {
        'contact': _contactController.text,
        'email': _emailController.text,
        'address': _addressController.text,
      },
    );

    if (response.statusCode == 200) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Help & Support information updated successfully!')),
      );
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update Help & Support information.')),
      );
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
          children: [
            TextField(
              controller: _contactController,
              decoration: InputDecoration(
                labelText: 'Contact Number',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Office Address',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _saveHelpSupportInfo,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.yellow,
              ),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
