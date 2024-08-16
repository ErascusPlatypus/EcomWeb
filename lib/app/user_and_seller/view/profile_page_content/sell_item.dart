import 'dart:async';
import 'dart:io';
import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:ecommerce_int2/app/user_and_seller/model/sell_item_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../../../../shared/widgets/InputDecorations.dart';
import '../profile_page/profile_page_seller.dart';

class SellItem extends StatefulWidget {
  static const routeName = "/sellItem";

  @override
  _SellItemState createState() => _SellItemState();
}

class _SellItemState extends State<SellItem> {
  String? category = "none";
  String imgurl = "", name = "", description = "";
  double price = 0.0;
  File? selectedImage;
  String status = '';
  String base64Image = "";
  late File? tmpFile;
  String errMessage = 'Error Uploading Image';
  String fileName = "";

  //TextController to read text entered in text field
  var name1 = new TextEditingController();
  var description1 = new TextEditingController();
  var price1 = new TextEditingController();
  var imgurl1 = new TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    name1.dispose();
    description1.dispose();
    price1.dispose();
    imgurl1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final email = context.extra;
    DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black)));
    return Scaffold(
      appBar: AppBar(
        title: Text('Sell Item'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login1.jpg'), fit: BoxFit.cover),
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
                    print(itemlist2);
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
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 15, left: 10, right: 10),
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
                                      onSaved: (String? value) {
                                        name = value!;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 15, left: 10, right: 10),
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
                                      onSaved: (String? value) {
                                        description = value!;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 15, left: 10, right: 10),
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
                                      onSaved: (String? value) {
                                        price = value as double;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      hint: Text("select category"),
                                      dropdownColor: Colors.blue[100],
                                      elevation: 5,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.blue))),
                                      items:
                                          itemlist2.map(buildMenuItem).toList(),
                                      onChanged: (value) =>
                                          setState(() => category = value),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 15, left: 10, right: 10),
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
                                      onSaved: (String? value) {
                                        imgurl = value!;
                                      },
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       bottom: 15, left: 10, right: 10),
                                  //   child: Column(
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.stretch,
                                  //     children: <Widget>[
                                  //       OutlineButton(
                                  //         onPressed: chooseImage,
                                  //         child: Text('Upload Product Image'),
                                  //       ),
                                  //       SizedBox(
                                  //         height: 20.0,
                                  //       ),
                                  //       //showImage(),
                                  //       SizedBox(
                                  //         height: 20.0,
                                  //       ),
                                  //       OutlineButton(
                                  //         onPressed: startUpload,
                                  //         child: Text('Upload Image'),
                                  //       ),
                                  //       SizedBox(
                                  //         height: 20.0,
                                  //       ),
                                  //       Text(
                                  //         status,
                                  //         textAlign: TextAlign.center,
                                  //         style: TextStyle(
                                  //           color: Colors.green,
                                  //           fontWeight: FontWeight.w500,
                                  //           fontSize: 20.0,
                                  //         ),
                                  //       ),
                                  //       SizedBox(
                                  //         height: 5.0,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),

                                  SizedBox(
                                    width: 200,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formkey.currentState!.validate()) {
                                          sellItemNow(email);
                                          return;
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            Colors.blue, // Set the text color
                                      ),
                                      child: Text('Sell Item'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return CircularProgressIndicator.adaptive();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  startUpload() {
    setStatus('Uploading Image...');
    // ignore: unnecessary_null_comparison
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    setState(() {
      fileName = tmpFile!.path.split('/').last;
    });
  }

  Future sellItemNow(String email) async {
    final _prefs = await SharedPreferences.getInstance();
    final userId = await _prefs.getString('userId') ?? '0';
    var postData = {
      'imageurl': imgurl1.text,
      'name': name1.text,
      'description': description1.text,
      'price': price1.text,
      'category': category,
      'email': email,
      'sellerId': userId,
    };
    var data = await UserController.sellItem(postData);
    if (data == "success") {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 2), () {
              imgurl1.clear();
              name1.clear();
              description1.clear();
              price1.clear();
              email = "";
              finish(context);
            });
            return AlertDialog(
              title: Text('Item listed'),
            );
          });
    } else if (data == "restriced") {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context)
                  .pushNamed(ProfilePageSeller.routeName, arguments: email);
            });
            return AlertDialog(
              title: Text('You are restricted!'),
            );
          });
    }
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  RaisedButton(
      {Color? color,
      required Null Function() onPressed,
      required RoundedRectangleBorder shape,
      required Color textColor,
      required Text child}) {}

// upload(String fileName) {
//   http.post(, body: {
//     "image": base64Image,
//     "name": fileName,
//   }).then((result) {
//     setStatus(result.statusCode == 200 ? result.body : errMessage);
//   }).catchError((error) {
//     setStatus(error);
//   });
// }

// Widget showImage() {
//   return Flexible(
//     child: Image.file(
//       File(_imageFileList![0].path),
//       fit: BoxFit.fill,
//     ),
//   );
// }
}
