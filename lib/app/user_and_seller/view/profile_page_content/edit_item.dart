import 'dart:async';
import 'dart:io';
import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:ecommerce_int2/app/user_and_seller/model/sell_item_data.dart';
import 'package:flutter/material.dart';
import '../../../../constants/apiEndPoints.dart';
import '../../../../shared/widgets/InputDecorations.dart';
import '../profile_page/profile_page_seller.dart';
import 'package:http/http.dart' as http;

class EditItem extends StatefulWidget {
  static const routeName = "/editItem";

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  String? category = "none";
  String imgurl = "", name = "", description = "";
  double price = 0.0;
  File? selectedImage;
  String status = '';
  String base64Image = "";
  File? tmpFile;
  String errMessage = 'Error Uploading Image';
  String fileName = "";
  String sellerBoost = "Inactive";

  // TextControllers to read text entered in text fields
  final TextEditingController name1 = TextEditingController();
  final TextEditingController description1 = TextEditingController();
  final TextEditingController price1 = TextEditingController();
  final TextEditingController imgurl1 = TextEditingController();
  final TextEditingController boost1 = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    name1.dispose();
    description1.dispose();
    price1.dispose();
    imgurl1.dispose();
    boost1.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize the values with widget.product
    final product = context.extra['product'];
    if (product != null) {
      imgurl1.text = product.imgurl;
      name1.text = product.name;
      description1.text = product.description;
      price1.text = product.price.toString();
    }
  }

  Future<void> updateSellerBoost(int pid, String sellerBoost) async {
    var url = Uri.parse(ApiEndPoints.baseURL + ApiEndPoints.update_seller_boost);
    final response = await http.post(
      url,
      body: {
        'pid': pid.toString(),
        'sellerBoost': sellerBoost,
      },
    );

    if (response.statusCode == 200) {
      print('Boost updated successfully.');
    } else {
      print('Failed to update boost.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = context.extra['product'];
    final email = context.extra['email'];

    DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.black,
          ),
        ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              FutureBuilder(
                future: UserController.fetchAllCategory(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var count = snapshot.data.length - 1;
                    List<Category1> itemlist = [];
                    List<String> itemlist2 = [];
                    for (var i = 0; i <= count; i++) {
                      itemlist.add(snapshot.data[i]);
                      itemlist2.add(itemlist[i].category);
                    }
                    category = itemlist2[int.parse(product!.categoryId) - 1];
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(top: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Form(
                              key: _formkey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    child: TextFormField(
                                      controller: name1,
                                      keyboardType: TextInputType.text,
                                      decoration: buildInputDecoration(
                                          Icons.add_box, "Product Name"),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter Name';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    child: TextFormField(
                                      controller: description1,
                                      keyboardType: TextInputType.text,
                                      decoration: buildInputDecoration(
                                          Icons.book, "Description"),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter description';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    child: TextFormField(
                                      controller: price1,
                                      keyboardType: TextInputType.number,
                                      decoration: buildInputDecoration(
                                          Icons.money, "Price"),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter price ';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: DropdownButtonFormField<String>(
                                      hint: Text("Select category"),
                                      value: category,
                                      dropdownColor: Colors.blue[100],
                                      elevation: 5,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(25),
                                          borderSide: BorderSide(
                                              width: 1.5,
                                              color: Colors.blue),
                                        ),
                                      ),
                                      items: itemlist2.map(buildMenuItem).toList(),
                                      onChanged: (value) =>
                                          setState(() => category = value),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    child: TextFormField(
                                      controller: imgurl1,
                                      keyboardType: TextInputType.text,
                                      decoration: buildInputDecoration(
                                          Icons.link, "Image Link"),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Please Enter Image Link';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    child: TextFormField(
                                      controller: boost1,
                                      keyboardType: TextInputType.text,
                                      decoration: buildInputDecoration(
                                          Icons.rocket_launch_sharp, "Boost"),
                                      onSaved: (String? value) {
                                        sellerBoost = value ?? "Inactive";
                                        if (product != null) {
                                          updateSellerBoost(
                                              int.parse(product.pid), sellerBoost);
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formkey.currentState!.validate()) {
                                          _formkey.currentState!.save();
                                          updateItemNow(
                                              int.parse(product!.pid), email);
                                          Navigator.pop(context, true);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.blue,
                                      ),
                                      child: Text('Update Item'),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future updateItemNow(int id, String email) async {
    var postData = {
      'pid': id.toString(),
      'imageurl': imgurl1.text,
      'name': name1.text,
      'description': description1.text,
      'price': price1.text,
      'category': category,
    };
    var data = await UserController.updateItem(postData);
    if (data == "success") {
      print(data);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product Updated'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    } else if (data == "restricted") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You are restricted!'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context)
            .pushNamed(ProfilePageSeller.routeName, arguments: email);
      });
    }
  }

  void setStatus(String message) {
    setState(() {
      status = message;
    });
  }
}
