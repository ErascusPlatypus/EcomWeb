
import 'package:ecommerce_int2/helper/base.dart';
import 'package:ecommerce_int2/shared/controllers/commonController.dart';
import 'package:flutter/material.dart';

import '../../model/getMessages.dart';

import 'MessageDialogBox.dart';


class ShowMessagesUser extends StatelessWidget {
  static const routeName = "/ShowMessagesUser";

  @override
  Widget build(BuildContext context) {
    final email = context.extra;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Messages'),
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
                  future: CommonController.getMessages(email),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator.adaptive());
                    }
                    print("%%%%");
                    print(snapshot.data);
                    List data = snapshot.data;
                    if (data.isNotEmpty ) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            GetMessages message = snapshot.data[index];

                            return Column(children: <Widget>[
                              ListTile(
                                title: Text(
                                  message.fromEmail == "sarthak@k.com"
                                      ? "Admin"
                                      : message.fromEmail,
                                  style: TextStyle(fontSize: 20),
                                ),
                                leading: Icon(
                                  Icons.people,
                                ),
                              ),
                              ListTile(
                                title: Text("Message: ${message.msg}"),
                              ),
                              ElevatedButton(
                                  onPressed: () => showMessageDialog(context,
                                      from: email, to: message.fromEmail),
                                  child: Text("Reply")),
                              Divider(),
                            ]);
                          });
                    } else {
                      return Padding(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 30,
                          ),
                          child: Text(
                            "No Messages",
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
