

import 'package:ecommerce_int2/helper/base.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import 'ProductsMarketPlace.dart';
import 'SellProductUser.dart';

class MarketPlaceProducts extends StatelessWidget {
  static const routeName = "/MarketPlaceProducts";
  @override
  Widget build(BuildContext context) {
    final email = context.extra;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "MarketPlace Products",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          Theme(
            data: ThemeData(canvasColor: Colors.white),
            child: DropdownButton(
                icon: Icon(Icons.more_vert, color: Colors.black),
                items: [
                  DropdownMenuItem(
                    value: 'SellProducts',
                    child: Row(
                      children: const [
                        Text(
                          "Sell your\nProduct",
                          overflow: TextOverflow.clip,
                        )
                      ],
                    ),
                  )
                ],
                onChanged: (itemIdentifier) {
                  if (itemIdentifier == 'SellProducts') {
                    // Navigator.of(context).pushReplacementNamed(
                    //     SellProductUser.routeName,
                    //     arguments: email);
                    launch(context, SellProductUser.routeName, email);
                  }
                }),
          )
        ],
      ),
      body: ProductMarketPlace(),
    );
  }
}
