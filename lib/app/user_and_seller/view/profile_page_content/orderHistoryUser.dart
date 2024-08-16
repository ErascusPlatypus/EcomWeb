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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: FutureBuilder(
                  future: UserController.fetchOrderHistory(email),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            OrderDetails request = snapshot.data[index];

                            return SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Center(
                                      child: Image.network(
                                        request.imgurl,
                                        fit: BoxFit.contain,
                                        height: 230,
                                        width: 230,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            request.imgurl,
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
                                    // leading: Image(image: image),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text("Seller: ${request.seller}"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                          "Total Amount: \u{20B9} ${request.totalAmount}"),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                          "Order date:  ${request.orderDate}"),
                                    ),
                                    if (request.deliveryDate.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                            "Delivery date:  ${request.orderDate}"),
                                      ),

                                    Divider(),
                                  ]),
                            );
                          });
                    } else {
                      Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 30,
                          ),
                          child: Text(
                            "No Pending Requests!",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ));
                    }
                    return CircularProgressIndicator.adaptive();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
