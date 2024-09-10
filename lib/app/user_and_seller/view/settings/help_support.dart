  import 'dart:convert';
  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
  
  import '../../../../constants/apiEndPoints.dart';
  
  class HelpSupportAdminPage extends StatefulWidget {
    @override
    _HelpSupportAdminPageState createState() => _HelpSupportAdminPageState();
  }
  
  class _HelpSupportAdminPageState extends State<HelpSupportAdminPage> {
    List<dynamic> _problems = [];
    bool _isLoading = true;
  
    @override
    void initState() {
      super.initState();
      _fetchProblems();
    }
  
    Future<void> _fetchProblems() async {
      final url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.help_support_get);  // Update the endpoint
  
      try {
        final response = await http.get(url);
  
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['status'] == 'success') {
            setState(() {
              _problems = data['data'];  // Update the problems list
            });
          } else {
            setState(() {
              _problems = [];
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No problems found.')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to fetch problems.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching problems: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }

    Future<void> _updateProblemStatus(String problemName, String status) async {
      final url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.help_support_update);

      try {
        final response = await http.post(
          url,
          body: {
            'problem': problemName,   // Send problem name instead of ID
            'status': status,
          },
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Status updated successfully!')),
          );
          _fetchProblems(); // Refresh the list
        } else {
          throw Exception('Failed to update status');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating status: $e')),
        );
      }
    }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Admin Help & Support'),
          backgroundColor: Colors.yellow,
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: _problems.isEmpty
              ? Center(child: Text('No problems to display.'))
              : ListView.builder(
            itemCount: _problems.length,
            itemBuilder: (context, index) {
              final problem = _problems[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Problem ID: ${problem['id']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text('User ID: ${problem['user_id']}'),
                      SizedBox(height: 8),
                      Text('Problem: ${problem['problem']}'),
                      SizedBox(height: 8),
                      Text('Status: ${problem['status']}',
                          style: TextStyle(
                            color: problem['status'] == 'resolved'
                                ? Colors.green
                                : Colors.orange,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 16),
                      DropdownButton<String>(
                        value: problem['status'],
                        onChanged: (String? newStatus) {
                          if (newStatus != null) {
                            // Pass problem['problem'] (the problem description) to the update function
                            String problemName = problem['problem'];
                            _updateProblemStatus(problemName, newStatus);
                          }
                        },
                        items: <String>['pending', 'resolved']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }
