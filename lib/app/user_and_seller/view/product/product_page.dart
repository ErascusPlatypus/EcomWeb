import 'dart:convert';

import 'package:ecommerce_int2/app/user_and_seller/view/product/search_page.dart';
import 'package:ecommerce_int2/constants/apiEndPoints.dart';
import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../../controller/userProductController.dart';
import '../../model/products.dart';
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
                            fontSize: 16.0)))
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
                      width: 130,
                      height: 100,
                      child: Center(child: orderNowButton),
                    ),
                  ),
                  SizedBox(
                    width: 40,
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
                    width: 130,
                    height: 100,
                    child: Center(child: viewProductButton),
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
