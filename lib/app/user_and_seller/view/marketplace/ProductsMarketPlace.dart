import 'package:ecommerce_int2/app/user_and_seller/controller/userProductController.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../model/UserSoldProducts.dart';
import '../product/product_page_user.dart';


class ProductMarketPlace extends StatelessWidget {
  static const routeName = "/ProductMarketPlace";

  @override
  Widget build(BuildContext context) {
    final email = context.extra;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/login1.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: FutureBuilder(
                  future: UserProductController.productListApi(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text("Loading..."),
                      );
                    }
                    if (snapshot.hasData) {
                      return Container(
                        padding: EdgeInsets.only(top: 22.0, right: 16.0, left: 16.0),
                        child: StaggeredGrid.count(
                          crossAxisCount: 4,

                          //itemCount: snapshot.data!.length,
                         // itemBuilder: (BuildContext context, int index) => new ClipRRect(
                          //  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            // child: InkWell(
                            //   onTap: () =>
                            //       Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductPageUser(email, product: snapshot.data[index]))),
                            //
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          children: (snapshot.data! as List<ProductsUser>)
                              .map(
                                (product) => ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              child: InkWell(
                                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductPageUser(email, product: product))),
                                child: Container(
                                        decoration: BoxDecoration(
                                          gradient: RadialGradient(colors: [
                                            Colors.grey.withOpacity(0.3),
                                            Colors.grey.withOpacity(0.7),
                                          ], center: Alignment(0, 0), radius: 0.6, focal: Alignment(0, 0), focalRadius: 0.1),
                                        ),
                                    child: Hero(tag: product.imgurl, child: Image.asset(product.imgurl))),
                                  ),
                            ),
                          )
                              .toList(),
                          ),
                          // staggeredTileBuilder: (int index) => Staggered.count(
                          //   mainAxisCellCount: 2,
                          //   crossAxisCellCount: index.isEven ? 3 : 2,
                          //   child: SizedBox(),
                          // ),


                      );
                    }
                    return Center(
                        child: Text(
                      "No products",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ));
                  }),
            ),
          ],
        ),
      ),
    );
  }


}
