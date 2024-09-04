import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/apiEndPoints.dart';

class AdminHelpSupportPage extends StatefulWidget {
  @override
  _AdminHelpSupportPageState createState() => _AdminHelpSupportPageState();
}

class _AdminHelpSupportPageState extends State<AdminHelpSupportPage> {
  List<dynamic> _problems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProblems();
  }

  Future<void> _fetchProblems() async {
    final url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.help_support_get);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _problems = data;
          _isLoading = false;
        });
      } else {
        // Handle server error
        print('Failed to load problems.');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      // Handle network error
      print('Error loading problems: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateProblemStatus(String problemId, String action) async {
    final url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.help_support_update);
    try {
      final response = await http.post(
        url,
        body: {
          'action': action,
          'problem_id': problemId,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'])),
        );
        _fetchProblems(); // Refresh the problem list
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update problem status.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating problem status: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage User Problems'),
        backgroundColor: Colors.yellow,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _problems.length,
        itemBuilder: (context, index) {
          final problem = _problems[index];
          return ListTile(
            title: Text('Problem ${problem['id']}'),
            subtitle: Text(problem['problem_description']),
            trailing: DropdownButton<String>(
              value: problem['status'],
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _updateProblemStatus(problem['id'], newValue);
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
          );
        },
      ),
    );
  }
}
