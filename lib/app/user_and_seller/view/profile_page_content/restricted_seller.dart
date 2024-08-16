
import 'package:ecommerce_int2/app/admin/controller/adminController.dart';
import 'package:ecommerce_int2/main.dart';

import 'package:flutter/material.dart';
import '../../model/Seller.dart';


class RestrictedSeller extends StatelessWidget {
  static const routeName = "/RestrictedSeller";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () =>  finish(context),
        ),
        title: Text('Restricted Sellers'),
      ),
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: FutureBuilder(
                  future: AdminController.fetchAllRestrictedSellers(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            Seller sellers = snapshot.data[index];

                            return Card(
                              elevation: 0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: [
                                  CircleAvatar(
                                    child: Image.asset(
                                      'assets/icons/settings_icon.png',
                                      fit: BoxFit.scaleDown,
                                      width: 40,
                                      height: 40,
                                    ),
                                    radius: 25,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12.0),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                        Text(sellers.email),
                                        //Divider(),
                                      ]),
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          });
                    } else {
                      Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 30,
                          ),
                          child: Text(
                            "No Restricted User!",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ));
                    }
                    return CircularProgressIndicator.adaptive();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
