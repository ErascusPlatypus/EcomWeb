import 'package:ecommerce_int2/app/delivery/view/profile_page/third_party_delivery_service.dart';
import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/profile_page/all_message.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/profile_page/edit_profile_page_seller.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/profile_page/serviceman_progress.dart';
import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../profile_page_content/faq_page.dart';
import '../profile_page_content/pending_requests.dart';
import '../profile_page_content/sell_item.dart';

import '../profile_page_content/tracking_page.dart';
import '../settings/settings_page.dart';
import '../wallet/wallet_page.dart';
import 'gst_info.dart';

class ProfilePageSeller extends StatefulWidget {
  static const routeName = "/ProfileSeller";

  @override
  State<ProfilePageSeller> createState() => _ProfilePageSellerState();
}

class _ProfilePageSellerState extends State<ProfilePageSeller> {
  String gstin = '17';
  late String email;
  String _name = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call the API here
      final email = context.extra;

      fetchProfile(email);
    });
  }

  @override
  Widget build(BuildContext context) {
    final email = context.extra;

    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: AppBar(
        backgroundColor: Color(0xffF9F9F9),
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    gstin == '18'
                        ? "GSTIN is not added, if available add GSTIN."
                        : "GSTIN added, but not verified, to verify add GSTIN document option to get verified.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                CircleAvatar(
                  maxRadius: 48,
                  backgroundImage: AssetImage('assets/background.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileSeller(),
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
                              onPressed: () =>
                                  launch(context, SellItem.routeName, email),
                            ),
                            Text(
                              'Sell Item',
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
                  title: Text('Third Party Delivery Service'),
                  subtitle: Text('Select Details'),
                  leading: Image.asset('assets/icons/support.png'),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: yellow,
                  ),
                  onTap: () => launch(
                      context, ThirdPartyDeliveryService.routeName, email),
                ),
                Divider(),
                ListTile(
                  title: Text('GSTIN Info'),
                  subtitle: Text('GST Number, Certificate, etc'),
                  leading: Icon(
                    Icons.monetization_on_outlined,
                    color: Colors.black54,
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: yellow,
                  ),
                  onTap: () {
                    print(email);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => GstPanInputScreen()));
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Messages'),
                  subtitle: Text('Received Messages'),
                  leading: Image.asset('assets/icons/support.png'),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: yellow,
                  ),
                  onTap: () {
                    print(email);
                      Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => MessageDetailsPage(adminEmail: email,)));
                  },
                ),
                Divider(),
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
                  title: Text('Pending Requests'),
                  subtitle: Text('Repairing services'),
                  leading: Image.asset('assets/icons/support.png'),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: yellow,
                  ),
                  onTap: () => launch(context, PendingRequest.routeName, email),
                ),
                   Divider(),
                ListTile(
                  title: Text('Serviceman Progress'),
                  subtitle: Text('Repairing services'),
                  leading: Image.asset('assets/icons/support.png'),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: yellow,
                  ),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => ServicemanProgress())),
                ),
                Divider(),
                ListTile(
                  enabled: false,
                  title: Text('Help & Support'),
                  subtitle: Text('Help center and legal support'),
                  leading: Image.asset('assets/icons/support.png'),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: yellow,
                  ),
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

  Future fetchProfile(String email) async {
    final _pref = await SharedPreferences.getInstance();
    ;
    setState(() {
      _name = _pref.getString('userName') ?? "";
    });
    var data = await UserController.fetchProfile(email);
    if (data['success'] == true) {
      print(data["message"]);
      print(data["data"]);
      gstin = data["data"]["gst"];
      setState(() {});
    }
  }
}
