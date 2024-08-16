import 'package:ecommerce_int2/main.dart';
import 'package:flutter/material.dart';

class ThirdPartyDeliveryService extends StatefulWidget {
  static const routeName = "/ThirdPartyDeliveryService";

  @override
  State<ThirdPartyDeliveryService> createState() =>
      ThirdPartyDeliveryServiceState();
}

class ThirdPartyDeliveryServiceState extends State<ThirdPartyDeliveryService> {
  List<String> selectedVehicles = [];
  Map<String, double> kmRates = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => finish(context)
        ),
        title: Text('Service Charges'),
      ),
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Wrap(
                children: [
                  for (String vehicle in [
                    'Bike',
                    'Car',
                    'Mini Lorry/Lorry',
                    'Other'
                  ]) // Add more vehicle types here
                    Row(
                      children: [
                        Checkbox(
                          value: selectedVehicles.contains(vehicle),
                          onChanged: (value) {
                            setState(() {
                              if (value!) {
                                selectedVehicles.add(vehicle);
                              } else {
                                selectedVehicles.remove(vehicle);
                              }
                              getKmRates();
                            });
                          },
                        ),
                        Text(
                          vehicle,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        // Display the vehicle name
                      ],
                    ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'KM Rates:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: selectedVehicles.map((vehicle) {
                  return Text(
                    '$vehicle: ${kmRates[vehicle]} / km',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getKmRates() {
    // Simulate API call and update kmRates
    // Replace this with your actual API call
    setState(() {
      kmRates = {
        'Bike': 5.0,
        'Car': 10.0,
        'Mini Lorry/Lorry': 15.0,
        'Other': 20.0,

        // Add more vehicle types and rates
      };
    });
  }
}
