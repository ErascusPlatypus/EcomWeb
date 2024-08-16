// ignore_for_file: unused_element

import 'dart:convert';

import 'package:ecommerce_int2/app/user_and_seller/view/product/view_product_page.dart';
import 'package:ecommerce_int2/helper/app_properties.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rubber/rubber.dart';

import '../../../../constants/apiEndPoints.dart';
import '../../model/products.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  final email2;
  SearchPage(this.email2);
  @override
  _SearchPageState createState() => _SearchPageState(email2);
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  final email;
  _SearchPageState(this.email);
  String selectedPeriod = "";
  String selectedCategory = "";
  String selectedPrice = "";
  List<dynamic> _searchResults = [];
  List<dynamic> _productResults = [];
  bool isProductFound = true;
  Future<void> fetchProduct(String keyword) async {
    final url =
        "${ApiEndPoints.baseURL}${ApiEndPoints.product_search}?name=$keyword";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(json.decode(response.body).runtimeType);
      if (json.decode(response.body).runtimeType.toString() != '_JsonMap') {
        isProductFound = true;
        List<dynamic> data = json.decode(response.body);

        //[{pid: 10, imgurl: assets/bag_1.png, name: Bag, description: Beautiful bag, price: 200, category_id: 5, seller_id: 2, gst: 19}, {pid: 14, imgurl: assets/bag_10.png, name: Bag Express, description: Bag for your shops, price: 2999, category_id: 5, seller_id: 2, gst: 19}]

        List<Products> productsList = data.map((productMap) {
          return Products.fromJson(
              productMap); // Ensure productMap is a Map<String, dynamic>
        }).toList();

        setState(() {
          _searchResults = productsList;
          _productResults = _searchResults;
          print(_searchResults);
        });
      } else {
        if (json.decode(response.body)['message'] == 'Product not found') {
          setState(() {
            isProductFound = false;
          });
        }
      }
    } else {
      print("Error in loading product");
    }
  }

  void _filterProductsByPriceRange(String priceRange) {
    setState(() {
      selectedPrice = priceRange;

      List<String> priceRangeParts = priceRange.split('-');
      String minPriceString =
          priceRangeParts[0].substring(1); // Remove the dollar sign and parse
      String maxPriceString = priceRangeParts[1];
      int minPrice = int.parse(minPriceString);
      int maxPrice = int.parse(maxPriceString);
      // print("$minPrice   $maxPrice   ");
      print(_searchResults);
      // Filter products based on price range
      _searchResults = _productResults.where((product) {
        int productPrice = int.parse(
            product.price.substring(1)); // Remove the dollar sign and parse
        // print(productPrice);
        return productPrice >= minPrice && productPrice <= maxPrice;
      }).toList();
      print(_searchResults);
    });
  }

  // List<Products> products = [
  //   Products(
  //       pid: '19',
  //       imgurl: 'assets/headphones_2.png',
  //       name: 'Skullcandy headset L325',
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
  //       price: '102.99',
  //       categoryId: '1',
  //       sellerId: '1',
  //       gst: '12'),
  //   Products(
  //       pid: '20',
  //       imgurl: 'assets/headphones_3.png',
  //       name: 'Skullcandy headset X25',
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
  //       price: '55.99',
  //       categoryId: '1',
  //       sellerId: '1',
  //       gst: '12'),
  //   Products(
  //       pid: '21',
  //       imgurl: 'assets/headphones.png',
  //       name: 'Blackzy PRO hedphones M003',
  //       description:
  //           'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor ut labore et dolore magna aliqua. Nec nam aliquam sem et tortor consequat id porta nibh. Orci porta non pulvinar neque laoreet suspendisse. Id nibh tortor id aliquet. Dui sapien eget mi proin. Viverra vitae congue eu consequat ac felis donec. Etiam dignissim diam quis enim lobortis scelerisque fermentum dui faucibus. Vulputate mi sit amet mauris commodo quis imperdiet. Vel fringilla est ullamcorper eget nulla facilisi etiam dignissim. Sit amet cursus sit amet dictum sit amet justo. Mattis pellentesque id nibh tortor. Sed blandit libero volutpat sed cras ornare arcu dui. Fermentum et sollicitudin ac orci phasellus. Ipsum nunc aliquet bibendum enim facilisis gravida. Viverra suspendisse potenti nullam ac tortor. Dapibus ultrices in iaculis nunc sed. Nisi porta lorem mollis aliquam ut porttitor leo a. Phasellus egestas tellus rutrum tellus pellentesque. Et malesuada fames ac turpis egestas maecenas pharetra convallis. Commodo ullamcorper a lacus vestibulum sed arcu non odio. Urna id volutpat lacus laoreet non curabitur gravida arcu ac. Eros in cursus turpis massa. Eget mauris pharetra et ultrices neque.',
  //       price: '152.99',
  //       categoryId: '1',
  //       sellerId: '1',
  //       gst: '12'),
  // ];

  List<String> timeFilter = [
    'Brand',
    'New',
    'Latest',
    'Trending',
    'Discount',
  ];

  List<String> categoryFilter = [
    'Skull Candy',
    'Boat',
    'JBL',
    'Micromax',
    'Seg',
  ];

  List<String> priceFilter = [
    '\$50-200',
    '\$200-400',
    '\$400-800',
    '\$800-1000',
  ];

  List<Products> searchResults = [];

  TextEditingController searchController = TextEditingController();

  late RubberAnimationController _controller;

  @override
  void initState() {
    _controller = RubberAnimationController(
        vsync: this,
        halfBoundValue: AnimationControllerValue(percentage: 0.4),
        upperBoundValue: AnimationControllerValue(percentage: 0.4),
        lowerBoundValue: AnimationControllerValue(pixel: 50),
        duration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _expand() {
    _controller.expand();
  }

  Widget _getLowerLayer() {
    List<dynamic> productToDisplay = _searchResults;
    return Container(
      margin: const EdgeInsets.only(top: kToolbarHeight),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Search',
                  style: TextStyle(
                    color: darkGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CloseButton()
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.orange, width: 1))),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  fetchProduct(value);
                  print("here");
                } else {
                  setState(() {
                    isProductFound = true;
                    searchResults.clear();
                    _productResults.clear();
                    //  searchResults.addAll(products);
                  });
                }
              },
              cursorColor: darkGrey,
              decoration: InputDecoration(
                hintText: 'Search product',
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                prefixIcon: SvgPicture.asset(
                  'assets/icons/search_icon.svg',
                  fit: BoxFit.scaleDown,
                ),
                suffix: !searchController.text.isEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            searchController.clear();
                            searchResults.clear();
                            _productResults.clear();
                          });
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.amber.shade900,
                        ))
                    : null,
              ),
            ),
          ),
          Flexible(
            child: Container(
              color: Colors.orange[50],
              child: isProductFound
                  ? ListView.builder(
                      itemCount: productToDisplay.length,
                      itemBuilder: (context, index) {
                        var result = productToDisplay[index];
                        return Column(
                          children: [
                            SizedBox(
                              height: 1,
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: ListTile(
                                  leading: Icon(Icons.search),
                                  horizontalTitleGap: 2,
                                  textColor: Colors.amber.shade900,
                                  onTap: () => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (_) => ViewProductPage(
                                                email,
                                                product: result,
                                              ))),
                                  title: Text(result.name),
                                )),
                          ],
                        );
                      })
                  : Center(
                      child: Text(
                      "Product not Found",
                      style: TextStyle(color: Colors.black),
                    )),
            ),
          )
        ],
      ),
    );
  }

  Widget _getUpperLayer() {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                offset: Offset(0, -3),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), topLeft: Radius.circular(24)),
          color: Colors.white),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
//          controller: _scrollController,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Filters',
                style: TextStyle(color: Colors.grey[300]),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 32.0, top: 16.0, bottom: 16.0),
              child: Text(
                'Sort By',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              itemBuilder: (_, index) => Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedPeriod = timeFilter[index];
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 20.0),
                        decoration: selectedPeriod == timeFilter[index]
                            ? BoxDecoration(
                                color: Color(0xffFDB846),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45)))
                            : BoxDecoration(),
                        child: Text(
                          timeFilter[index],
                          style: TextStyle(fontSize: 16.0),
                        ))),
              )),
              itemCount: timeFilter.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              itemBuilder: (_, index) => Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedCategory = categoryFilter[index];
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 20.0),
                        decoration: selectedCategory == categoryFilter[index]
                            ? BoxDecoration(
                                color: Color(0xffFDB846),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45)))
                            : BoxDecoration(),
                        child: Text(
                          categoryFilter[index],
                          style: TextStyle(fontSize: 16.0),
                        ))),
              )),
              itemCount: categoryFilter.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Container(
            height: 50,
            child: ListView.builder(
              itemBuilder: (_, index) => Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: InkWell(
                    onTap: () {
                      print(priceFilter[index]);
                      _filterProductsByPriceRange(priceFilter[index]);
                      setState(() {
                        selectedPrice = priceFilter[index];
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 20.0),
                        decoration: selectedPrice == priceFilter[index]
                            ? BoxDecoration(
                                color: Color(0xffFDB846),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45)))
                            : BoxDecoration(),
                        child: Text(
                          priceFilter[index],
                          style: TextStyle(fontSize: 16.0),
                        ))),
              )),
              itemCount: priceFilter.length,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        top: true,
        bottom: false,
        child: Scaffold(
//          bottomSheet: ClipRRect(
//            borderRadius: BorderRadius.only(
//                topRight: Radius.circular(25), topLeft: Radius.circular(25)),
//            child: BottomSheet(
//                onClosing: () {},
//                builder: (_) => Container(
//                      padding: EdgeInsets.all(16.0),
//                      child: Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[Text('Filters')]),
//                      color: Colors.white,
//                      width: MediaQuery.of(context).size.height,
//                    )),
//          ),
// body: Column(
//   children: [
//     // _getLowerLayer(),
//     // _getLowerLayer(),
//         RubberBottomSheet(
//           lowerLayer: _getLowerLayer(), // The underlying page (Widget)
//           upperLayer: _getUpperLayer(), // The bottomsheet content (Widget)
//           animationController: _controller, // The one we created earlier
//         ),
//   ],
// )
          body: RubberBottomSheet(
            lowerLayer: _getLowerLayer(), // The underlying page (Widget)
            upperLayer: _getUpperLayer(), // The bottomsheet content (Widget)
            animationController: _controller, // The one we created earlier
          ),
        ),
      ),
    );
  }

//   FlatButton({required Null Function() onPressed, required Text child}) {}
}
