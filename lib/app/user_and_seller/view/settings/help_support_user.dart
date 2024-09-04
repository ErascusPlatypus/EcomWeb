import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/apiEndPoints.dart';

class HelpSupportPageUser extends StatefulWidget {
  @override
  _HelpSupportPageUserState createState() => _HelpSupportPageUserState();
}

class _HelpSupportPageUserState extends State<HelpSupportPageUser> {
  final _problemController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submitProblem() async {
    final url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.help_support_update);
    setState(() {
      _isSubmitting = true;
    });

    try {
      final response = await http.post(
        url,
        body: {
          'problem': _problemController.text,
          // Optionally include user details like user ID if needed
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Handle success response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Problem submitted successfully!')),
        );
        _problemController.clear();
      } else {
        // Handle server error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit problem.')),
        );
      }
    } catch (e) {
      // Handle network error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting problem: $e')),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
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
              'Submit your problem:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _problemController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Describe your problem here...',
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submitProblem,
              child: _isSubmitting
                  ? CircularProgressIndicator()
                  : Text('Submit'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
            ),
          ],
        ),
      ),
    );
  }
}
