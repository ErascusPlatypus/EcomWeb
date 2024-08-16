import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:ecommerce_int2/constants/apiEndPoints.dart';
import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:ecommerce_int2/app/user_and_seller/model/product.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:flutter/material.dart';
import '../../../model/products.dart';
import '../../product/product_page.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ProductList extends StatelessWidget {
  List<Product> products;

  final SwiperController swiperController = SwiperController();
  final email;
  ProductList(this.email, {required this.products});

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height / 2.7;
    double cardWidth = MediaQuery.of(context).size.width / 1.8;

    return SizedBox(
      height: cardHeight,
      child: FutureBuilder(
        future: UserController.fetchAllProducts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Swiper(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                Products products = snapshot.data[index];
                return ProductCard(email,
                    height: cardHeight, width: cardWidth, product: products);
              },
              scale: 0.8,
              controller: swiperController,
              viewportFraction: 0.6,
              loop: false,
              fade: 0.5,
              pagination: SwiperCustomPagination(
                builder: (context, config) {
                  if (config.itemCount > 20) {
                    print(
                        "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation");
                  }
                  Color activeColor = mediumYellow;
                  Color color = Colors.grey.withOpacity(.3);
                  double size = 10.0;
                  double space = 5.0;

                  if (config.indicatorLayout != PageIndicatorLayout.NONE &&
                      config.layout == SwiperLayout.DEFAULT) {
                    return new PageIndicator(
                      count: config.itemCount,
                      controller: config.pageController!,
                      layout: config.indicatorLayout,
                      size: size,
                      activeColor: activeColor,
                      color: color,
                      space: space,
                    );
                  }

                  List<Widget> dots = [];

                  int itemCount = config.itemCount;
                  int activeIndex = config.activeIndex;

                  for (int i = 0; i < itemCount; ++i) {
                    bool active = i == activeIndex;
                    dots.add(Container(
                      key: Key("pagination_$i"),
                      margin: EdgeInsets.all(space),
                      child: ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: active ? activeColor : color,
                          ),
                          width: size,
                          height: size,
                        ),
                      ),
                    ));
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: dots,
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            );
          } else {
            return Text('No data');
          }
          // return Container(height: 100,width: 300,child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final Products product;
  final double height;
  final double width;
  final email2;
  const ProductCard(
    this.email2, {
    required this.product,
    required this.height,
    required this.width,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isLiked = false;

  Future<void> insertLikedProduct({
    required String pid,
    required String imageUrl,
    required String name,
    required String description,
    required double price,
    required int categoryId,
    required int sellerId,
    required double gst,
    required String emailId,
  }) async {
    var url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.liked_product);

    var data = {
      'pid': pid,
      'imageurl': imageUrl,
      'name': name,
      'description': description,
      'price': price.toString(),
      'categoryid': categoryId.toString(),
      'seller_id': sellerId.toString(),
      'gst': gst.toString(),
      'email_id': emailId,
    };

    try {
      var response = await http.post(url, body: data);

      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);

        if (res['message'] == "exists") {
          setState(() {
            isLiked = true;
          });
          context.toast("Already liked this product");
        } else if (res["message"] == "success") {
          setState(() {
            isLiked = true;
          });
          context.toast("Added to liked List");
        }
        // print('Data sent successfully');
        print('Response: ${response.body}');
        // Handle success response here
      } else {
        print('Failed to send data');
        // Handle error response here
      }
    } catch (e) {
      print('Error: $e');
      // Handle network error here
    }
  }

  Future<void> deleteLikedProduct(int pid, String email) async {
    final String url = ApiEndPoints.baseURL + ApiEndPoints.liked_product_delete;

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'pid': pid.toString(),
          'email_id': email,
        },
      );

      if (response.statusCode == 200) {
        // Handle success response
        print('Product deleted successfully');
      } else {
        // Handle error response
        print('Failed to delete product');
      }
    } catch (error) {
      // Handle network errors
      print('Network error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ProductPage(widget.email2, product: widget.product))),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 30),
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              color: mediumYellow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: isLiked
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  onPressed: () async {
                    //write isliked function to save the product and send to backend

                    await insertLikedProduct(
                        pid: widget.product.pid,
                        imageUrl: widget.product.imgurl,
                        name: widget.product.name,
                        description: widget.product.description,
                        price: double.parse(widget.product.price),
                        categoryId: int.parse(widget.product.categoryId),
                        sellerId: int.parse(widget.product.sellerId),
                        gst: double.parse(widget.product.gst),
                        emailId: widget.email2);
                  },
                  color: isLiked ? Colors.red : Colors.white,
                ),
                Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.product.name,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        )),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 12.0, 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: Color.fromRGBO(224, 69, 10, 1),
                        ),
                        child: Text(
                          '\₹${widget.product.price}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            child: Hero(
                tag: widget.product.imgurl,
                child: Image.network(
                  height: widget.height / 1.7,
                  width: widget.width / 1.4,
                  fit: BoxFit.contain,
                  widget.product.imgurl,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      widget.product.imgurl,
                      height: widget.height / 1.7,
                      width: widget.width / 1.4,
                      fit: BoxFit.contain,
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
