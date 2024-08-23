import 'package:flutter/material.dart';
import 'PhonePayPayment.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                  hintText: "Enter amount", border: OutlineInputBorder()),
            ),
            ElevatedButton(
              onPressed: () {
                final amount = int.tryParse(textEditingController.text);
                if (amount != null) {
                  // Initiating the PhonePe payment process
                  PhonepePg(context: context, amount: amount).init();
                } else {
                  // Handle invalid input
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter a valid amount'),
                    ),
                  );
                }
              },
              child: const Text("Check out"),
            ),
          ],
        ),
      ),
    );
  }
}
