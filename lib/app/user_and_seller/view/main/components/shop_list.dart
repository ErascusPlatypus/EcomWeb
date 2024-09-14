import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:ecommerce_int2/app/user_and_seller/model/category.dart';
import 'package:flutter/material.dart';
import '../../../model/Seller.dart';
import '../../category/components/staggered_card2.dart';

class ShopListPage extends StatefulWidget {
  final email2;
  ShopListPage(this.email2);
  @override
  _ShopListPageState createState() => _ShopListPageState(email2);
}

class _ShopListPageState extends State<ShopListPage> {
  final email;
  _ShopListPageState(this.email);
  List<Category> searchResults = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Dispose the controller when the widget is removed
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffF9F9F9),
      child: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment(-1, 0),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'Shops List',
                  style: TextStyle(
                    color: darkGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Flexible(
              child: FutureBuilder(
                future: UserController.fetchAllSeller(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    // Separate restricted and non-restricted sellers
                    var unrestrictedSellers = snapshot.data!
                        .where((seller) => seller.isRestrict == "0")
                        .toList();

                    var restrictedSellers = snapshot.data!
                        .where((seller) => seller.isRestrict == "1")
                        .toList();

                    // Concatenate unrestricted sellers followed by restricted sellers
                    var allSellers = unrestrictedSellers + restrictedSellers;

                    return ListView.builder(
                      itemCount: allSellers.length,
                      itemBuilder: (_, index) {
                        Seller sellerItem = allSellers[index];
                        bool isRestricted = sellerItem.isRestrict == "1";

                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.0,
                          ),
                          child: StaggeredCardCard2(
                            email,
                            // Use different color for restricted sellers
                            begin: isRestricted ? Colors.red : Colors.purple,
                            end: isRestricted ? Colors.redAccent : Colors.purpleAccent,
                            categoryName: sellerItem.shopName,
                            assetPath: 'assets/icons/shop.png',
                            sellerId: sellerItem.id,
                            isRestricted: isRestricted,
                          ),
                        );
                      },
                    );
                  }
                  return CircularProgressIndicator.adaptive();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
