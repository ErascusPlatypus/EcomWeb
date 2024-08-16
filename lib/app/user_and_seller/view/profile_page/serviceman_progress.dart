import 'package:ecommerce_int2/constants/apiEndPoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'bookingdetailsModel.dart';

class ServicemanProgress extends StatefulWidget {
  @override
  _ServicemanProgressState createState() =>
      _ServicemanProgressState();
}

class _ServicemanProgressState extends State<ServicemanProgress> {
  List<BookingDetails> bookingDetailsList = [];

  @override
  void initState() {
    super.initState();
    fetchBookingDetails();
  }

  Future<void> fetchBookingDetails() async {
    final _prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse(ApiEndPoints.baseURL+ApiEndPoints.serviceman_progress),
      body: {'seller_email': await _prefs.getString('userEmail')},
    );

    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      setState(() {
        bookingDetailsList = decodedData
            .map((data) => BookingDetails.fromJson(data))
            .toList();
      });
    } else {
      // Handle error
      print('Failed to fetch booking details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Serviceman Progress")),
      body: ListView.builder(
        itemCount: bookingDetailsList.length,
        itemBuilder: (context, index) {
          final booking = bookingDetailsList[index];
          return Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User: ${booking.user}'),
                Text('Seller: ${booking.seller}'),
                Text('Address: ${booking.address}'),
                Text('Issue: ${booking.issue}'),
                Text('Date: ${booking.date}'),
                Text('Time: ${booking.time}'),
                Text('Mechanic Phone: ${booking.mechanicPhone}'),
                Text('Serviceman Email: ${booking.servicemanEmail}'),
                Text('Repair Time: ${booking.repairTime}'),
                Text('Serviceman Status: ${booking.servicemanStatus}'),
                Text('Feedback: ${booking.feedback}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
