import 'package:ecommerce_int2/app/admin/controller/adminController.dart';
import 'package:ecommerce_int2/main.dart';
import 'package:ecommerce_int2/app/user_and_seller/model/Users.dart';

import 'package:flutter/material.dart';

class RestrictedUser extends StatelessWidget {
  static const routeName = "/RestrictedUser";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => finish(context),
        ),
        title: Text('Restricted Users'),
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
                  future: AdminController.fetchAllRestrictedUsers(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            Users users = snapshot.data[index];

                            return Column(children: <Widget>[
                              ListTile(
                                title: Text(users.email),
                                leading: Icon(
                                  Icons.people,
                                ),
                              ),
                              Divider(),
                            ]);
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
