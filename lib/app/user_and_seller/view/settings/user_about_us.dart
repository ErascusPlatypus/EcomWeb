import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../constants/apiEndPoints.dart';

class AboutUsPageUser extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPageUser> {
  String title = '';
  String description = '';

  @override
  void initState() {
    super.initState();
    _fetchAboutUsInfo();
  }

  Future<void> _fetchAboutUsInfo() async {
    final url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.about_us_get);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          title = data['title'] ?? 'About Us';
          description = data['description'] ?? 'No information available.';
        });
      } else {
        // Handle server error
        setState(() {
          title = 'Error';
          description = 'Failed to load About Us information.';
        });
      }
    } catch (e) {
      // Handle network error
      setState(() {
        title = 'Error';
        description = 'An error occurred while loading the About Us information.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.yellow[700], // Yellow theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Black text
              ),
            ),
            SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87, // Darker black text for readability
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white, // White background
    );
  }
}
