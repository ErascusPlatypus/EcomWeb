import 'package:flutter/material.dart';

//Dhanush
//used in the login screen - New __ ? __ here
class RegisterTextButton extends StatelessWidget {
  final String mainText;
  final String actionText;
  final VoidCallback onTap;

  const RegisterTextButton({
    Key? key,
    required this.mainText,
    required this.actionText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            text: mainText,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'OpenSans',
              fontSize: 17.0,
              color: Colors.black54,
            ),
            children: [
              TextSpan(
                text: actionText,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                  fontFamily: 'OpenSans',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
