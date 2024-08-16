import 'package:ecommerce_int2/app/user_and_seller/view/legalAndAbout/license.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/legalAndAbout/privacy_policy.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/legalAndAbout/return_policy.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/legalAndAbout/seller_policy.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/legalAndAbout/terms.dart';
import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LegalAboutPage extends StatefulWidget {
  @override
  _LegalAboutPageState createState() => _LegalAboutPageState();
}

class _LegalAboutPageState extends State<LegalAboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Settings',
          style: TextStyle(color: darkGrey),
        ),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Legal & About',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
              Flexible(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text('Terms of Use'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => TermsUse()));
                      },
                    ),
                    ListTile(
                        title: Text('Privacy Policy'),
                        trailing: Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => PrivacyPolicy()));
                        }),
                    ListTile(
                      title: Text('License'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => License()));},
                    ),
                    ListTile(
                      title: Text('Seller Policy'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => SellerPolicy()));},
                    ),
                    ListTile(
                      title: Text('Return Policy'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => ReturnPolicy()));},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
