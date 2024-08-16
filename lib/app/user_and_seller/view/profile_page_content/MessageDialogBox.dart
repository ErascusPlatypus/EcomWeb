import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:flutter/material.dart';

Future<T?> showMessageDialog<T>(
  BuildContext context, {
  required String from,
  required String to,
}) =>
    showDialog(
        context: context,
        builder: (context) => MessageDialogBox(
              from: from,
              to: to,
            ));

class MessageDialogBox extends StatefulWidget {
  final String from;
  final String to;

  MessageDialogBox({
    Key? key,
    required this.from,
    required this.to,
  }) : super(key: key);

  @override
  State<MessageDialogBox> createState() => _MessageDialogBoxState();
}

class _MessageDialogBoxState extends State<MessageDialogBox> {
  Future confirmRequest(BuildContext context) async {
    // var postData = {
    //   'from': widget.from,
    //   'to': widget.to,
    //   'msg': controller.text,
    // };
    var postData = {
      'senderID': widget.from,
      'receiverID': widget.to,
      'body': controller.text,
    };
    print(postData);
    var data = await UserController.confirmSendMessage(postData);
    if (data['status'] == "success") {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 2), () {
              controller.clear();
              Navigator.of(context).pop();
            });
            return AlertDialog(
              title: Text('Message sent'),
            );
          });
          
    }
    print(data);
  }

  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Send Message"),
      content: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          )),
      actions: [
        ElevatedButton(
            onPressed: () => confirmRequest(context),
            child: Text(
              "Send",
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
