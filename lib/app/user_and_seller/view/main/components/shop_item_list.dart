import 'package:ecommerce_int2/helper/base.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import '../../../../../constants/apiEndPoints.dart';
import '../../../../../helper/app_properties.dart';
import '../../../model/products.dart';
import '../../product/product_page.dart';



class ShopList extends StatefulWidget {
  static const routeName = "/ShopList";

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  @override
  Widget build(BuildContext context) {
    final arguments = context.extra as List;
    final sellerId = arguments[0];
    final email = arguments[1];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/login1.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 26,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  IntrinsicHeight(
                    child: Container(
                      margin: const EdgeInsets.only(left: 16.0, right: 8.0),
                      width: 4,
                      color: mediumYellow,
                    ),
                  ),
                  Center(
                      child: Text(
                    'Shop Products',
                    style: TextStyle(
                        color: Colors.purple[700],
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  )),
                ],
              ),
            ),
            Flexible(
              child: FutureBuilder(
                  future: shopListApi(sellerId),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    if (snapshot.hasData) {
                      return Container(
                        padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
                        child: StaggeredGrid.count(
                          //physics: NeverScrollableScrollPhysics(),
                          //padding: EdgeInsets.zero,
                          crossAxisCount: 4,
                          //itemCount: snapshot.data!.length,
                          children: (snapshot.data! as List<Products>)
                              .map(
                                (product) => ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              child: InkWell(
                                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProductPage(email, product: product))),
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
                          /*staggeredTileBuilder: (int index) => StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: index.isEven ? 3 : 2,
                        child: SizedBox(),
                      ),*/
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          axisDirection: AxisDirection.right,
                        ),
                      );
                    }
                    return CircularProgressIndicator.adaptive();
                  }),
            ),
          ],
        ),
      ),
    );
  }
  //
  Future<List<Products>> shopListApi(String sellerId) async {
    var url = ApiEndPoints.baseURL + ApiEndPoints.shopitemlistapi;

    Map postData = {
      'sellerid': sellerId,
    };
    /////print(postData);
    var response = await http.post(Uri.parse(url), body: postData);

    /////print(response.body.toString());

    /////print(data);
    return productsFromJson(response.body);
  }
}
