import 'package:ecommerce_int2/app/admin/controller/adminController.dart';
import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:ecommerce_int2/app/user_and_seller/model/Users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../constants/colors.dart';
import '../../../../main.dart';
import 'MessageDialogBox.dart';



class RestrictUser extends StatefulWidget {
  static const routeName = "/RestrictUser";

  @override
  State<RestrictUser> createState() => _RestrictUserState();
}

class _RestrictUserState extends State<RestrictUser> {
  String button = "";

  @override
  Widget build(BuildContext context) {
    final email = context.extra;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: () => finish(context), icon: Icon(CupertinoIcons.chevron_back, color: AppColor.icon)),
        title: Text('All users', style: TextStyle(color: AppColor.header)),
        backgroundColor: AppColor.background,
      ),
      backgroundColor: AppColor.background,
      //backgroundColor: Color(0xffF9F9F9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: FutureBuilder(
                future: UserController.fetchAllUsers(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          Users users = snapshot.data[index];
                          String change = "0";
                          if (users.isRestrict == "0") {
                            change = "1";
                            button = "Restrict";
                          } else {
                            button = "Unrestrict";
                          }
                          return Card(
                            elevation: 0,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
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
                                        Text(
                                          users.email,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            MaterialButton(
                                              onPressed: () => restrictUser(users.email, change, context),
                                              color: AppColor.primary,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                              height: 30,
                                              child: Text(button, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                            ),
                                            MaterialButton(
                                              onPressed: () => showMessageDialog(context, from: email, to: users.email),
                                              color: AppColor.primary,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                              height: 30,
                                              child: Text("Message", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                            ),
                                          ],
                                        ),

                                        ///Divider(),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  return CircularProgressIndicator.adaptive();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future restrictUser(String email, String change, BuildContext context) async {

    String msg = "";
    if (change == "1") {
      msg = "$email restricted!";
    } else {
      msg = "$email unrestricted!";
    }
    var data = await AdminController.restrictUser(email, change);
    if (data == "done") {
      context.toast(msg);
    } else {
      if (data == "notdone") {
        context.toast('Some error occurred');
      }
    }
    setState(() {});
  }
}
