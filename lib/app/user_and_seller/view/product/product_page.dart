import 'dart:convert';

import 'package:ecommerce_int2/app/user_and_seller/view/product/search_page.dart';
import 'package:ecommerce_int2/constants/apiEndPoints.dart';
import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../../controller/userProductController.dart';
import '../../model/products.dart';
import '../rating/rating_page.dart';
import '../user_place_order/place_order_and_confom.dart';
import 'components/product_display.dart';

class ProductPage extends StatefulWidget {
  final Products product;
  final email;
  ProductPage(this.email, {required this.product});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var _isAdded = false;


  @override
  void initState() {
    super.initState();
    // Call addUserHistory when the page loads
    addUserHistory(
      product_id: widget.product.pid,
      pd_image_url: widget.product.imgurl,
      product_name: widget.product.name,
      product_price: int.parse(widget.product.price),
      categoryId: int.parse(widget.product.categoryId),
      seller_id: int.parse(widget.product.sellerId),
      user_email: widget.email,
    );
  }

  Future<void> addUserHistory({
    required String product_id,
    required String pd_image_url,
    required String product_name,
    required int product_price,
    required int categoryId,
    required int seller_id,
    required String user_email,
  }) async {
    var url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.add_user_history);

    var data = {
      'user_id': '5',
      'product_id': product_id,
      'pd_image_url': pd_image_url,
      'product_name': product_name,
      'product_price': product_price,
      'categoryid': categoryId,
      'seller_id': seller_id,
      'user_email': user_email,
    };

    try {
      var response = await http.post(url, body: data);

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);

        if (res['message'] == "success") {
          // Optionally provide feedback to the user here
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Added to history")),
          );
        }

        print('\n \n\ \n Data inserted \n\n\n ');
        print('Response: ${response.body}');
      } else {
        print('Failed to send data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    void _addToCart() async {
      await UserProductController.addToCart(
              email: widget.email, productId: widget.product.pid)
          .then((value) {
        if (value == "done") {
          setState(() {
            _isAdded = true;
          });
        }
      });
    }

    _updateTotalOrders() async {
      final url = Uri.parse('https://yourdomain.com/update_orders.php');

      try {
        var response = await http.post(
            Uri.parse(ApiEndPoints.baseURL+ApiEndPoints.update_sales), body: {
          'seller_id': widget.product.sellerId,
        });

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          if (responseData['success']) {
            print('Order updated successfully');
          } else {
            print('Failed to update order');
          }
        } else {
          print('Server error');
        }
      } catch (e) {
        print('Error: $e');
      }
    }

    //buyNow
    _buyNow() async {
      try {
        var res = await http.post(
          Uri.parse(ApiEndPoints.baseURL+ApiEndPoints.buy_now),
          body: {
            "userId": "5",
            "userEmail": widget.email,
            "productId": widget.product.pid,
            "productName": widget.product.name,
            "productDescription": widget.product.description,
            "productPrice": widget.product.price,
            "pdImageUrl": widget.product.imgurl,
            "sellerId": widget.product.sellerId,
          },
        );
        if (res.statusCode == 200) {
          var resBodyOfBuyNow = jsonDecode(res.body);
          if (resBodyOfBuyNow['success'] == true) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return OrderConfirmationScreen(widget.email,
                  product: widget.product);
            }));
          } else {
            Dialog(
              child: Text("something got wrong"),
            );
          }
        }
      } catch (e) {
        print(e.toString());
      }
    }

    Widget viewProductButton = InkWell(
      child: Container(
        height: 80,
        width: width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: GestureDetector(
          onTap: _isAdded ? null : _addToCart,
          child: Center(
            child: Text(_isAdded ? "Added" : "Add to Cart",
                style: const TextStyle(
                    color: const Color(0xfffefefe),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0)),
          ),
        ),
      ),
    );

    //buy now placed  Now Button //
    Widget orderNowButton = InkWell(
      child: Container(
        height: 80,
        width: width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: GestureDetector(
          onTap: () {
            //this is send to placed order and confirm page
            //and the data is saved into db
            _updateTotalOrders();
            _buyNow();
          },
          child: Center(
            child: Text("Buy Now",
                style: const TextStyle(
                    color: const Color(0xfffefefe),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0)),
          ),
        ),
      ),
    );

    //added by Dhanush - also adjusted sizing of the other buttons to accomodate this
    Widget ratingButton = InkWell(
      child: Container(
        height: 80,
        width: width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RatingPage(widget.email),
              ),
            );
          },
          child: Center(
            child: Text("Rate Now",
                style: const TextStyle(
                    color: const Color(0xfffefefe),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0)),
          ),
        ),
      ),
    );
    // finished addition

    return Scaffold(
      backgroundColor: yellow,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: darkGrey),
        actions: <Widget>[
          IconButton(
            icon: new SvgPicture.asset(
              'assets/icons/search_icon.svg',
              fit: BoxFit.scaleDown,
            ),
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => SearchPage(widget.email))),
          )
        ],
        title: Text(
          'Headphones',
          style: const TextStyle(
              color: darkGrey, fontWeight: FontWeight.w500, fontSize: 18.0),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 80.0,
                ),
                ProductDisplay(
                  widget.email,
                  product: widget.product,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 16.0),
                  child: Text(
                    widget.product.name,
                    style: const TextStyle(
                        color: const Color(0xFFFEFEFE),
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 90,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(253, 192, 84, 1),
                          borderRadius: BorderRadius.circular(4.0),
                          border:
                              Border.all(color: Color(0xFFFFFFFF), width: 0.5),
                        ),
                        child: Center(
                          child: new Text("Details",
                              style: const TextStyle(
                                  color: const Color(0xeefefefe),
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0)),
                        ),
                      )
                    ],
                  ),
                ),
                //ratingPageButton,
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                    padding:
                        EdgeInsets.only(left: 20.0, right: 40.0, bottom: 130),
                    child: new Text(widget.product.description,
                        style: const TextStyle(
                            color: const Color(0xfefefefe),
                            fontWeight: FontWeight.w800,
                            fontFamily: "NunitoSans",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.0)
                    )
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 400,
              child: Row(
                children: [
                  //order Now designing and function CalledHere
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 8.0,
                          bottom: bottomPadding != 20 ? 20 : bottomPadding),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            Color.fromRGBO(255, 255, 255, 0),
                            Color.fromRGBO(253, 192, 84, 0.5),
                            Color.fromRGBO(253, 192, 84, 1),
                          ],
                              begin: FractionalOffset.topCenter,
                              end: FractionalOffset.bottomCenter)),
                      width: 110,
                      height: 100,
                      child: Center(child: orderNowButton),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),

                  Container(
                    padding: EdgeInsets.only(
                        top: 8.0,
                        bottom: bottomPadding != 20 ? 20 : bottomPadding),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Color.fromRGBO(255, 255, 255, 0),
                          Color.fromRGBO(253, 192, 84, 0.5),
                          Color.fromRGBO(253, 192, 84, 1),
                        ],
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter)),
                    width: 120,
                    height: 100,
                    child: Center(child: viewProductButton),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 8.0,
                        bottom: bottomPadding != 20 ? 20 : bottomPadding),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(255, 255, 255, 0),
                              Color.fromRGBO(253, 192, 84, 0.5),
                              Color.fromRGBO(253, 192, 84, 1),
                            ],
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter)),
                    width: 110,
                    height: 100,
                    child: Center(child: ratingButton),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
