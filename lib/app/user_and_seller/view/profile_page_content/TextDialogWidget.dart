import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:flutter/material.dart';
import '../../../admin/view/profile_page/extra_charges_admin.dart';
import 'pending_requests.dart';

Future<T?> showTextDialog<T>(BuildContext context,
        {required String title,
        required String value,
        required String id,
        String? rid,
        String? seller}) =>
    showDialog(
        context: context,
        builder: (context) => TextDialogWidget(
              title: title,
              value: value,
              id: id,
              rid: rid,
              seller: seller,
            ));

// ignore: must_be_immutable
class TextDialogWidget extends StatefulWidget {
  final String title;
  final String value;
  final String id;
  String? rid;
  String? seller;

  TextDialogWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.id,
    this.rid,
    this.seller,
  }) : super(key: key);

  @override
  State<TextDialogWidget> createState() => _TextDialogWidgetState();
}

class _TextDialogWidgetState extends State<TextDialogWidget> {
  Future confirmRequest(BuildContext context, String id) async {
    var postData = {
      'shopid': id,
      'gst': controller.text,
    };
    var data = await UserController.updateGSTShop(postData);
    if (data == "success") {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => ExtraChargesAdmin()));
            });
            return AlertDialog(
              title: Text('Changes Confirmed'),
            );
          });
    }
  }

  Future confirmAppointment(String id, String rid, BuildContext context) async {
    var postData = {
      'id': id,
      'text': widget.id == 'time' ? category : controller.text,
      'rid': rid
    };
    var data = await UserController.changeRepairDateTime(postData);
    if (data == "success") {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pushReplacementNamed(
                  PendingRequest.routeName,
                  arguments: widget.seller);
            });
            return AlertDialog(
              title: Text('Change Confirm'),
            );
          });
    }
  }

  late TextEditingController controller;

  String? category = "none";

  List<String> itemlist2 = [
    "10 PM - 12 PM",
    "12 PM - 2 PM",
    "2 PM - 4 PM",
    "4 PM - 6 PM",
    "6 PM - 8 PM"
  ];
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.black)));
    return AlertDialog(
      title: Text(widget.title),
      content: widget.id == "time"
          ? DropdownButtonFormField<String>(
              hint: Text(
                "Timeslot",
                softWrap: true,
              ),
              dropdownColor: Colors.blue[100],
              elevation: 5,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(width: 1.5, color: Colors.blue))),
              items: itemlist2.map(buildMenuItem).toList(),
              onChanged: (value) => setState(() => category = value),
            )
          : TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              )),
      actions: [
        ElevatedButton(
            onPressed: (widget.id == "time" || widget.id == "date")
                ? () =>
                    confirmAppointment(widget.id, widget.rid ?? '0', context)
                : () => confirmRequest(context, widget.id),
            child: Text(
              "Change",
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
