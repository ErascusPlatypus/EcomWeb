// ignore_for_file: deprecated_member_use

import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../model/products.dart';
import '../../product/components/color_list.dart';
import '../../product/components/shop_product.dart';
import '../../user_place_order/place_order_and_confirm.dart';

class ShopItemList extends StatefulWidget {
  final Products product;
  final double service;
  final double gst;
  final double transFee;
  final double total;
  final String email; // Add email for passing to the confirmation screen
  final VoidCallback onRemove;

  ShopItemList(this.product, this.service, this.gst, this.transFee, this.total,
      {required this.onRemove, required this.email});

  @override
  _ShopItemListState createState() => _ShopItemListState();
}

class _ShopItemListState extends State<ShopItemList> {
  int quantity = 1;
  double totalPrice = 0.0;
  var expanded = false ;

  @override
  void initState() {
    super.initState();
    totalPrice = widget.total;  // Set initial total price
  }

  void _updateTotalPrice() {
    setState(() {
      totalPrice = (double.parse(widget.product.price) * quantity) + widget.service + widget.gst + widget.transFee;
    });
  }

  void _navigateToOrderConfirmation() {
    // Navigate to the OrderConfirmationScreen with email and product
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OrderConfirmationScreen(
        email: widget.email,
        product: widget.product,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: expanded ? 320 : 130,  // Adjusted height for Buy Now button
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment(0, 0.9),
              child: Column(
                children: [
                  Container(
                      height: 118,
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: shadow,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 12.0, right: 12.0),
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.product.name,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: darkGrey,
                                    ),
                                    softWrap: true,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      width: 160,
                                      padding: const EdgeInsets.only(
                                          top: 15.0, bottom: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          ColorOption(Colors.red),
                                          GestureDetector(
                                            onTap: () => setState(() {
                                              expanded = !expanded;
                                            }),
                                            child: Column(
                                              children: [
                                                Text(
                                                  '\u{20B9}${totalPrice.toStringAsFixed(2)}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: darkGrey,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 17.0),
                                                ),
                                                Icon(Icons.arrow_drop_down),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Theme(
                              data: ThemeData(
                                  textTheme: TextTheme(
                                    headline6: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    bodyText1: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 12,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  colorScheme: ColorScheme.fromSwatch()
                                      .copyWith(secondary: Colors.black)),
                              child: NumberPicker(
                                value: quantity,
                                minValue: 1,
                                maxValue: 10,
                                onChanged: (value) {
                                  setState(() {
                                    quantity = value;
                                    _updateTotalPrice();  // Update total price based on quantity
                                  });
                                },
                                axis: Axis.vertical,
                                itemWidth: 20,
                              ),
                            )
                          ])),
                  if (expanded)
                    Container(
                      height: 150, // Adjust height if needed
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: shadow,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: SingleChildScrollView(  // Wrap the content with SingleChildScrollView
                        child: Column(
                          children: [
                            ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                ElevatedButton(
                                  onPressed: _navigateToOrderConfirmation,
                                  child: Text('Buy Now'),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black, backgroundColor: Colors.yellow[700], // Text color
                                  ),
                                ),
                                SizedBox(height: 10),
                                // Buy Now Button
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Price:"),
                                    Text(double.parse(widget.product.price)
                                        .toStringAsFixed(2)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Service charge:"),
                                    Text(widget.service.toStringAsFixed(2)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("GST:"),
                                    Text(widget.gst.toStringAsFixed(2)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Transaction Fee:"),
                                    Text(widget.transFee.toStringAsFixed(2)),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total:"),
                                    Text(totalPrice.toStringAsFixed(2)),  // Updated total price
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              )),
          Positioned(
              top: 5,
              child: ShopProductDisplay(
                widget.product,
                onPressed: widget.onRemove,
              )),
        ],
      ),
    );
  }
}

