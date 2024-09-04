import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/profile_page/edit_profile_page.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/profile_page/liked_product.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/settings/help_support_user.dart';
import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../marketplace/marketPlacePage.dart';
import '../payment/payment_page.dart';
import '../profile_page_content/appointments_user.dart';
import '../profile_page_content/faq_page.dart';
import '../profile_page_content/orderHistoryUser.dart';
import '../profile_page_content/repair_shopwork.dart';
import '../profile_page_content/showMessageUser.dart';
import '../profile_page_content/tracking_page.dart';
import '../settings/settings_page.dart';
import '../wallet/wallet_page.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = "/Profile";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  XFile? _mediaFileList;
  String profileUrl = '';
  final ImagePicker _picker = ImagePicker();
  String _name = '';
  Future getImage() async {
    _mediaFileList = await _picker.pickImage(
      imageQuality: 70,
      source: ImageSource.gallery,
    );
    await UserController.uploadUserProfile(
        base64Encode(File(_mediaFileList!.path).readAsBytesSync()));
  }

  Future getProfileUrl() async {
    final _prefs = await SharedPreferences.getInstance();
    profileUrl = (await _prefs.getString('profile'))!;
    _name = _prefs.getString('userName') ?? '';
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getProfileUrl();
  }

  @override
  Widget build(BuildContext context) {
    final email = context.extra;

    Future<String> fetchWallet() async {
      var response = await UserController.fetchWallet(email);
      return response;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Profile Page",
          style: TextStyle(fontSize: 16),
        ),
      ),
      backgroundColor: Color(0xffF9F9F9),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    await getImage();
                    setState(() {});
                  },
                  child: _mediaFileList != null
                      ? Image.file(
                          File(_mediaFileList!.path),
                          width: 48,
                          fit: BoxFit.cover,
                        )
                      : profileUrl.isEmpty
                          ? CircleAvatar(
                              maxRadius: 48,
                              backgroundImage:
                                  AssetImage('assets/background.jpg'),
                            )
                          : Image.network(
                              profileUrl,
                              width: 48,
                              fit: BoxFit.cover,
                            ),

                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfilePage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Profile'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.amber),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    email,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                FutureBuilder<String?>(
                    future: fetchWallet(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator.adaptive();
                      }
                      String walletBal =
                          snapshot.data!.isEmpty ? "0" : snapshot.data!;
                      //if not working
                      //String walletBal = snapshot.data ?? "0";
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Refferal Wallet: \₹${walletBal}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      );
                    }),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: transparentYellow,
                            blurRadius: 4,
                            spreadRadius: 1,
                            offset: Offset(0, 1))
                      ]),
                  height: 150,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/icons/wallet.png'),
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => WalletPage())),
                            ),
                            Text(
                              'Wallet',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/icons/truck.png'),
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => TrackingPage())),
                            ),
                            Text(
                              'Shipped',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/icons/card.png'),
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) => PaymentPage())),
                            ),
                            Text(
                              'Payment',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/icons/contact_us.png'),
                              onPressed: () {},
                            ),
                            Text(
                              'Support',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Settings'),
                  subtitle: Text('Privacy and logout'),
                  leading: Image.asset(
                    'assets/icons/settings_icon.png',
                    fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,
                  ),
                  trailing: Icon(Icons.chevron_right, color: yellow),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SettingsPage())),
                ),
                Divider(),
                ListTile(
                  title: Text('Liked Products'),
                  subtitle: Text('Wish to buy products'),
                  leading: Image.asset(
                    'assets/icons/settings_icon.png',
                    fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,
                  ),
                  trailing: Icon(Icons.chevron_right, color: yellow),
                  onTap: () {
                    launch(context, LikedProduct.routeName);
                  },
                ),
                Divider(),
                ListTile(
                    enabled: true,
                    title: Text('Marketplace'),
                    subtitle: Text('Sell your own product'),
                    leading: Image.asset(
                      'assets/icons/settings_icon.png',
                      fit: BoxFit.scaleDown,
                      width: 30,
                      height: 30,
                    ),
                    trailing: Icon(Icons.chevron_right, color: yellow),
                    onTap: () =>
                        launch(context, MarketPlaceProducts.routeName, email)),
                Divider(),
                ListTile(
                    enabled: true,
                    title: Text('Order History'),
                    subtitle: Text('All previous orders'),
                    leading: Image.asset(
                      'assets/icons/settings_icon.png',
                      fit: BoxFit.scaleDown,
                      width: 30,
                      height: 30,
                    ),
                    trailing: Icon(Icons.chevron_right, color: yellow),
                    onTap: () =>
                        launch(context, OrderHistroyUser.routeName, email)),
                Divider(),
                ListTile(
                    enabled: true,
                    title: Text('Messages'),
                    subtitle: Text('Received Messages'),
                    leading: Image.asset('assets/icons/support.png'),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: yellow,
                    ),
                    onTap: () =>
                        launch(context, ShowMessagesUser.routeName, email)),
                Divider(),
                ListTile(
                    enabled: true,
                    title: Text('Repair Shopwork'),
                    subtitle: Text('Seller will provide'),
                    leading: Image.asset(
                      'assets/icons/settings_icon.png',
                      fit: BoxFit.scaleDown,
                      width: 30,
                      height: 30,
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: yellow,
                    ),
                    onTap: () =>
                        launch(context, RepairShopwork.routeName, email)),
                Divider(),
                ListTile(
                    enabled: true,
                    title: Text('Repair Appointments'),
                    subtitle: Text('Requested appointments'),
                    leading: Image.asset(
                      'assets/icons/support.png',
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: yellow,
                    ),
                    onTap: () =>
                        launch(context, AppointmentUser.routeName, email)),
                Divider(),
                ListTile(
                  enabled: true,
                  title: Text('Help & Support'),
                  subtitle: Text('Help center and legal support'),
                  leading: Image.asset('assets/icons/support.png'),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: yellow,
                  ),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => HelpSupportPageUser())),
                ),
                Divider(),
                ListTile(
                  title: Text('FAQ'),
                  subtitle: Text('Questions and Answer'),
                  leading: Image.asset('assets/icons/faq.png'),
                  trailing: Icon(Icons.chevron_right, color: yellow),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => FaqPage())),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
