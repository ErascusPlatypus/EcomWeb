import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/apiEndPoints.dart';

class HelpSupportPageSeller extends StatefulWidget {
  @override
  _HelpSupportPageSellerState createState() => _HelpSupportPageSellerState();
}

class _HelpSupportPageSellerState extends State<HelpSupportPageSeller> {
  final _problemController = TextEditingController();
  bool _isSubmitting = false;
  List<dynamic> _problems = [];  // To store the problems fetched from the server

  @override
  void initState() {
    super.initState();
    _fetchProblems();  // Fetch existing problems when the page loads
  }

  Future<void> _submitProblem() async {
    final url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.help_support_insert);  // Update the endpoint
    setState(() {
      _isSubmitting = true;
    });

    try {
      final response = await http.post(
        url,
        body: {
          'user_id': '6789',  // Replace with actual user ID
          'problem': _problemController.text,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Problem submitted successfully!')),
          );
          _problemController.clear();
          _fetchProblems();  // Fetch the updated list of problems
        } else {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to submit problem.')),
          );
        }
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

  Future<void> _fetchProblems() async {
    final url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.help_support_get + '?user_id=6789');  // Update the endpoint

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            _problems = data['data'];  // Update the problems list
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No problems found.')),
          );
        }
      } else {
        // Handle server error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to fetch problems.')),
        );
      }
    } catch (e) {
      // Handle network error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching problems: $e')),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Problem Submission Section
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

            // Divider to separate the sections
            Divider(height: 32, color: Colors.grey),

            // Submitted Problems Section
            Text(
              'Your Submitted Problems:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: _problems.isEmpty
                  ? Center(child: Text('No problems submitted yet.'))
                  : ListView.builder(
                itemCount: _problems.length,
                itemBuilder: (context, index) {
                  final problem = _problems[index];
                  return ListTile(
                    title: Text(problem['problem']),
                    subtitle: Text('Status: ${problem['status']}'),
                    leading: Icon(
                      problem['status'] == 'resolved'
                          ? Icons.check_circle
                          : Icons.pending,
                      color: problem['status'] == 'resolved'
                          ? Colors.green
                          : Colors.orange,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
