import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../constants/apiEndPoints.dart';
import 'serviceman_page.dart';

class ServicemanUpdate extends StatefulWidget {
  ServicemanUpdate({
    super.key,
    required this.id,
    required this.feedback,
  });
  final int id;
  final String? feedback;
  @override
  State<ServicemanUpdate> createState() => _ServicemanUpdateState();
}

class _ServicemanUpdateState extends State<ServicemanUpdate> {
  TextEditingController serviceman_status = TextEditingController();
  TextEditingController feedback = TextEditingController();

  Future<void> updateStatus() async {
    try {
      String bookingId = widget.id.toString();
      String feedbacK = feedback.text;
      String servicman_Status = serviceman_status.text;
      DateTime currentTime = DateTime.now();
      String repairTime = currentTime.toIso8601String();

      var res = await http.post(
        Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.serviceman_status_update),
        body: {
          'id': bookingId,
          'serviceman_status': servicman_Status,
          'feedback': feedbacK,
          'repair_time': repairTime
        },
      );

      if (res.statusCode == 200) {
        var responseOfBody = jsonDecode(res.body);
        print(responseOfBody);

        if (responseOfBody['success'] == true) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ServicemanPage()),
          );
        } else {
          print("Some Issues");
        }
      } else {
        print(res.statusCode);
      }
    } catch (e) {
      print("error is $e");
    }
  }

  @override
  void initState() {
    super.initState();
    feedback = TextEditingController(text: widget.feedback);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    serviceman_status.dispose();
    feedback.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Serviceman Update"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextFormField(
              controller: serviceman_status,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter the O Or 1",
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: feedback,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter the feedback",
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  updateStatus();
                },
                child: Text("Save Changes"))
          ],
        ),
      ),
    );
  }
}
