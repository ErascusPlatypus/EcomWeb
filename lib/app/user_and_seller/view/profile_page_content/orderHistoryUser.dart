import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:flutter/material.dart';
import '../../model/orderDetails.dart';

class OrderHistroyUser extends StatelessWidget {
  static const routeName = "/OrderHistoryUser";

  @override
  Widget build(BuildContext context) {
    final email = context.extra;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Order History'),
      ),
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: FutureBuilder<List<OrderDetails>>(
              future: UserController.fetchOrderHistory(email),
              builder: (context, AsyncSnapshot<List<OrderDetails>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Text(
                        "No Pending Requests!",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: snapshot.data!.map((OrderDetails request) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image.network(
                                request.imgurl,
                                fit: BoxFit.contain,
                                height: 230,
                                width: 230,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/placeholder.png', // Provide a placeholder image
                                    fit: BoxFit.contain,
                                    height: 230,
                                    width: 230,
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                request.productName,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text("Seller: ${request.seller}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text("Total Amount: \u{20B9} ${request.totalAmount}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text("Order date: ${request.orderDate}"),
                            ),
                            if (request.deliveryDate.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text("Delivery date: ${request.deliveryDate}"),
                              ),
                            Divider(),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
