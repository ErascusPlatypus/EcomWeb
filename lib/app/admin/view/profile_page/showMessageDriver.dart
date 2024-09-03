import 'dart:convert';
import 'package:ecommerce_int2/app/admin/view/profile_page/profile_page_admin.dart';
import 'package:ecommerce_int2/shared/controllers/commonController.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../constants/apiEndPoints.dart';
import '../../../user_and_seller/model/getMessages.dart';
import '../../../user_and_seller/view/profile_page/profile_page_seller.dart';
import '../../../user_and_seller/view/profile_page_content/MessageDialogBox.dart';

class ShowMessagesDriver extends StatelessWidget {
  static const routeName = "/ShowMessagesDriver";

  Future<List<dynamic>> checkForNewEntries() async {
    final response = await http.get(Uri.parse(
        ApiEndPoints.baseURL + ApiEndPoints.fetch_admin_kyc));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data; // Assuming data is a list of rows
    } else {
      throw Exception('Failed to load new entries');
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pushReplacementNamed(
              ProfilePageAdmin.routeName,
              arguments: email),
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
                  future: checkForNewEntries(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator.adaptive());
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            var entry = snapshot.data[index];

                            return Column(children: <Widget>[
                              ListTile(
                                title: Text(
                                  "Driver ID: ${entry['driver_id']}",
                                  style: TextStyle(fontSize: 20),
                                ),
                                leading: Icon(
                                  Icons.person,
                                ),
                              ),
                              ListTile(
                                title: Text("Created At: ${entry['created_at']}"),
                              ),
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
                            "No new entries",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )
                      );
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
