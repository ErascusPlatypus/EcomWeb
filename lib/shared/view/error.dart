import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key, this.error, this.errorBuilder}) : super(key: key);

  final String? error;
  final (BuildContext, GoRouterState)? errorBuilder;
  static const routeName = '/error';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shope')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(children: [
            Text(
              'Sorry, an error was encountered!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 30),
            Text(
              error ?? 'Error: 404\n\n Page doesn\'t exist!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Colors.redAccent,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
