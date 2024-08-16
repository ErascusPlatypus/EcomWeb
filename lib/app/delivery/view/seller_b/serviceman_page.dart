import 'dart:convert';

import 'package:ecommerce_int2/app/delivery/view/seller_b/serviceman_update.dart';
import 'package:ecommerce_int2/constants/apiEndPoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../user_and_seller/view/profile_page/bookingdetailsModel.dart';

class ServicemanPage extends StatefulWidget {
  const ServicemanPage({super.key});

  @override
  State<ServicemanPage> createState() => _ServicemanPageState();
}

class _ServicemanPageState extends State<ServicemanPage> {
  List<BookingDetails> bookingDetailsList = [];
  @override
  void initState() {
    super.initState();
    fetchBookingDetails();
  }

  Future<void> fetchBookingDetails() async {
    final _prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.serviceman_home),
      body: {'serviceman_email': await _prefs.getString('userEmail')},
    );

    if (response.statusCode == 200) {
      final List<dynamic> decodedData = json.decode(response.body);
      setState(() {
        bookingDetailsList =
            decodedData.map((data) => BookingDetails.fromJson(data)).toList();
      });
    } else {
      // Handle error
      print('Failed to fetch booking details');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Serviceman Home"),
      ),
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
              color: Colors.orange,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text('id: ${booking.id}'),
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
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ServicemanUpdate(
                          id: booking.id,
                          feedback: booking.feedback!,
                        );
                      }));
                    },
                    child: Text(booking.servicemanStatus == 0
                        ? "Please Confirm The service"
                        : "You are accepted the service"))
              ],
            ),
          );
        },
      ),
    );
  }
}
