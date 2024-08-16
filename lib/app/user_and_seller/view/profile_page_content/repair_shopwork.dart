import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:ecommerce_int2/helper/base.dart';



import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../model/services.dart';
import 'repair_request.dart';

class RepairShopwork extends StatelessWidget {
  static const routeName = "/Repair";
  @override
  Widget build(BuildContext context) {
   // final email = ModalRoute.of(context)!.settings.arguments as String;
    final email = context.extra;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () =>  Navigator. of(context). pop(),
        ),
        title: Text('Services'),
      ),
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              children: [
                FutureBuilder(
                  future: UserController.fetchAllServices(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            RepairApi services = snapshot.data[index];
                            return Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text(services.service),
                                  onTap: () {
                                    launch(context, RepairRequest.routeName, [email,services.sellerId,services.service]);
                                  },
                                  leading: Image.asset(
                                    'assets/icons/settings_icon.png',
                                    fit: BoxFit.scaleDown,
                                    width: 30,
                                    height: 30,
                                  ),
                                  trailing:
                                      Icon(Icons.chevron_right, color: yellow),
                                ),
                                Divider(),
                              ],
                            );
                          });
                    }
                    return CircularProgressIndicator.adaptive();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
