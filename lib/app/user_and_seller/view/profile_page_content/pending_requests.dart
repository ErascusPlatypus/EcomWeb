import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:ecommerce_int2/app/user_and_seller/model/pendingRequests.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:ecommerce_int2/main.dart';
import 'package:flutter/material.dart';

import '../profile_page/profile_page_seller.dart';
import 'TextDialogWidget.dart';
import 'accept_repair.dart';

class PendingRequest extends StatelessWidget {
  static const routeName = "/PendingRequests";

  @override
  Widget build(BuildContext context) {
    final email = context.extra;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => finish(context)),
        title: Text('Pending Requests'),
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
                  future: UserController.postEmail(email),
                  builder: (context, AsyncSnapshot snapshot) {
                    List data = snapshot.data ?? [];
                    if (data.isNotEmpty) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            PendingRequests request = snapshot.data[index];

                            return SingleChildScrollView(
                              child: Column(children: <Widget>[
                                ListTile(
                                  title: Text(
                                    request.service,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  leading: Icon(
                                    Icons.people,
                                  ),
                                ),
                                ListTile(
                                  title: Text("Issue: ${request.issue}"),
                                ),
                                ListTile(
                                  title: Text("User: ${request.user}"),
                                ),
                                ListTile(
                                  title: Text("State: ${request.state}"),
                                ),
                                ListTile(
                                  title: Text("City: ${request.city}"),
                                ),
                                ListTile(
                                  title: Text("Locality: ${request.locality}"),
                                ),
                                ListTile(
                                  title: Text("Landmark: ${request.landmark}"),
                                ),
                                ListTile(
                                  title: Text("Address: ${request.address}"),
                                ),
                                ListTile(
                                  title: Text("Phone: ${request.phone}"),
                                ),
                                ListTile(
                                  title: Text(
                                    "Timeslot: ${request.timeslot}",
                                  ),
                                  trailing: GestureDetector(
                                      onTap: () => showTextDialog(context,
                                          title: "Change Timeslot",
                                          value: request.timeslot,
                                          id: "time",
                                          rid: request.rid,
                                          seller: request.seller),
                                      child: Icon(Icons.edit)),
                                ),
                                ListTile(
                                  title: Text(
                                    "Date: ${request.date}",
                                  ),
                                  trailing: GestureDetector(
                                      onTap: () => showTextDialog(context,
                                          title: "Change Date",
                                          value: request.date,
                                          id: "date",
                                          rid: request.rid,
                                          seller: request.seller),
                                      child: Icon(Icons.edit)),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          launch(context,
                                              RepairRequestAccept.routeName, [
                                            request.user,
                                            request.seller,
                                            request.service,
                                            request.rid,
                                            request.address,
                                            request.issue,
                                            request.date,
                                            request.timeslot
                                          ]);
                                        },
                                        child: Text(
                                          "Accept",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    ElevatedButton(
                                        onPressed: () {
                                          UserController.rejectRepair(
                                              request.rid);
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  ProfilePageSeller.routeName,
                                                  arguments: request.seller);
                                        },
                                        child: Text(
                                          "Reject",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                                Divider(),
                              ]),
                            );
                          });
                    } else {
                      return Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 30,
                          ),
                          child: Text(
                            "No Pending Requests!",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ));
                    }
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
