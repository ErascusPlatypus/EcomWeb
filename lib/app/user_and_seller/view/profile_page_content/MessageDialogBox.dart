import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:flutter/material.dart';

Future<T?> showMessageDialog<T>(
    BuildContext context, {
      required String from,
      required String to,
    }) =>
    showDialog<T>(
      context: context,
      builder: (context) => MessageDialogBox(
        from: from,
        to: to,
      ),
    );

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
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> confirmRequest(BuildContext context) async {
    final postData = {
      'from': widget.from,
      'to': widget.to,
      'msg': controller.text,
    };

    try {
      print(postData);
      final data = await UserController.confirmSendMessage(postData);

      if (data['status'] == 'success') {
        Navigator.of(context).pop(); // Close the dialog
        showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop(); // Close the success dialog
            });
            return AlertDialog(
              title: Text('Message sent'),
            );
          },
        );
      } else {
        // Handle unsuccessful response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send message')),
        );
      }
    } catch (e) {
      // Handle exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Send Message ${widget.from}, ${widget.to}'),
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter your message',
        ),
        maxLines: 3, // Allows multiline input
      ),
      actions: [
        ElevatedButton(
          onPressed: () => confirmRequest(context),
          child: Text(
            'Send',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Cancel action
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
