import 'package:ecommerce_int2/helper/app_properties.dart';


import 'package:flutter/material.dart';

import '../../../model/products.dart';
import '../../rating/rating_page.dart';

class ProductDisplay extends StatelessWidget {
  final Products product;
  final email;
  const ProductDisplay(
    this.email, {
    required this.product,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            top: 30.0,
            right: 0,
            child: Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 85,
                padding: EdgeInsets.only(right: 24),
                decoration: new BoxDecoration(
                    color: darkGrey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.16),
                          offset: Offset(0, 3),
                          blurRadius: 6.0),
                    ]),
                child: Align(
                  alignment: Alignment(1, 0),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '\u{20B9}${product.price}',
                        style: const TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Montserrat",
                            fontSize: 36.0)),
                  ])),
                ))),
        Align(
          alignment: Alignment(-1, 0),
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Container(
              height: screenAwareSize(220, context),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 18.0,
                    ),
                    child: Container(
                      child: Hero(
                        tag: product.imgurl,
                        child: Image.network(
                          product.imgurl,
                          fit: BoxFit.contain,
                          height: 230,
                          width: 230,
                          errorBuilder:(context, error, stackTrace) {
                            return Image.asset(
                          product.imgurl,
                          fit: BoxFit.contain,
                          height: 230,
                          width: 230,
                        );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 20.0,
          bottom: 0.0,
          child: RawMaterialButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => RatingPage(email))),
            constraints: const BoxConstraints(minWidth: 45, minHeight: 45),
            child:
                Icon(Icons.favorite, color: Color.fromRGBO(255, 137, 147, 1)),
            elevation: 0.0,
            shape: CircleBorder(),
            fillColor: Color.fromRGBO(255, 255, 255, 0.4),
          ),
        )
      ],
    );
  }
}
