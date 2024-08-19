import 'package:flutter/material.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size ;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
            image: const AssetImage('assets/minions.jpg'),
            height: size.height * 0.2,
        ),
        Text(
          'Glad To Meet You',
          style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w700,
          fontFamily: 'OpenSans',
          color: Colors.orangeAccent,
          ),
        ),
        Text(
          'Create your new account for future use' ,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.yellow[700],
              fontWeight: FontWeight.w600,
            ),
        )
      ],
    );
  }
}
