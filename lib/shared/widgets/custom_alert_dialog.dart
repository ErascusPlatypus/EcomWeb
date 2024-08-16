import 'package:ecommerce_int2/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatefulWidget {
  final bool isSuccess;
  final String? title;
  final String message;

  CustomAlertDialog({
    required this.isSuccess,
    this.title,
    required this.message,
  });

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(25)),
      title: DefaultTextStyle(
        style: TextStyle(color: AppColor.primary, fontSize: 25, fontWeight: FontWeight.bold),
        child: Align(
          alignment: Alignment.topLeft,
          child: widget.title == null ? (widget.isSuccess ? Text('Login Successful') : Text('Login Failed')) : Text(widget.title!),
        ),
      ),
      content: FadeTransition(
        opacity: _animation,
        child: Text(
          widget.message.toUpperCase(),
          style: TextStyle(color: AppColor.header),
        ),
      ),
      /*actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],*/
    );
  }
}
