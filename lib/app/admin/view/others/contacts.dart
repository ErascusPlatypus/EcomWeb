import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_int2/app/admin/controller/adminController.dart';
import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:ecommerce_int2/shared/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class ContactsList extends StatefulWidget {
  static const routeName = "/Contacts";

  const ContactsList();

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  List<Contact> _contacts = [];
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    _requestContactsPermission();
  }

  Future<void> _requestContactsPermission() async {
    var status = await Permission.contacts.request();
    if (status.isGranted) {
      fetchContacts();
    } else {
      // Handle denied permission or show a message to the user
    }
  }

  Future<void> fetchContacts() async {
    print("fetching ");
    try {
      Iterable<Contact> contacts = await ContactsService.getContacts(withThumbnails: false);
      setState(() {
        _contacts = contacts.toList();
      });
    } catch(e){
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            uploadContacts(_contacts);
          },
          child: Text('Phone Contacts'),
        ),
      ),
      body: RefreshIndicator(
        key: _refreshKey,
        onRefresh: _handleRefresh,
        child: FutureBuilder(
          future: AdminController.fetchAllContacts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Map mp = snapshot.data;
              return ListView.builder(
                itemCount: mp.length,
                itemBuilder: (context, index) {
                  String key = mp.keys.elementAt(index);
                  String value = mp[key];
                  return ListTile(
                    title: Text(key),
                    subtitle: Text(value),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      /*body: Scrollbar(
        thickness: 6,
        child: ListView.builder(
          itemCount: _contacts.length,
          itemBuilder: (context, index) {
            Contact contact = _contacts[index];
            return GestureDetector(
              onTap: () => context.toast(contact.toMap()),
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/icons/img_profile.png'),
                  ),
                  title: Text(contact.displayName ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(contact.phones!.isNotEmpty ? contact.phones?.first.value ?? '' : 'No phone number'),
                ),
              ),
            );
          },
        ),
      ),*/
    );
  }

  Future<void> uploadContacts(List<Contact> contact) async {
    var mp = Map.fromIterables(
      contact.map((e) => e.displayName).toList(),
      contact.map((e) => e.phones?.isNotEmpty == true ? e.phones![0].value : null).toList(),
    );
    mp.mremove;
    var postData = {
      'email': 'asd',
      'name': jsonEncode(mp.keys.toList().sublist(0, mp.keys.length)),
      'phone': jsonEncode(mp.values.toList().sublist(0, mp.values.length)),
    };

    var formdata = FormData.fromMap(postData);
      var data = await UserController.uploadContacts(formdata);
      if (data['success'] == '0') {
        _showCustomAlertDialog(context, true, 'Error!', data['message']);
      } else if (data['success'] == '1') {
        _handleRefresh();
        _showCustomAlertDialog(context, true, 'Registration successful!', data['message']);
      } else {
        _showCustomAlertDialog(context, true, 'Registration failed!', data['message']);
      }
  }

  _showCustomAlertDialog(BuildContext context, bool isSuccess, String? title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          isSuccess: isSuccess,
          message: message,
          title: title,
        );
      },
    );
  }
  Future<void> _handleRefresh() async {
    setState(() {
    });


    setState(() {
    });
  }
}


