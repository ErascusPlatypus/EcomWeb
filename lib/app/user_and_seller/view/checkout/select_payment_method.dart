import 'package:card_swiper/card_swiper.dart';
import 'package:ecommerce_int2/app/user_and_seller/controller/userController.dart';
import 'package:ecommerce_int2/app/user_and_seller/model/products.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/main/main_page.dart';
import 'package:ecommerce_int2/app/user_and_seller/view/shop/components/credit_card.dart';
import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:flutter/material.dart';

class SelectPaymentMethod extends StatefulWidget {
  static final routeName = "/selectPaymentMethod";
  const SelectPaymentMethod({super.key});

  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  int? cashOnDelivery;
  SwiperController swipeController = SwiperController();
  @override
  void dispose() {
    // TODO: implement dispose
    swipeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Products product = context.extra['product'];
    final address = context.extra['address'];
    final grandTotal = context.extra['grandTotal'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Payment Methods",
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.w600,
            fontSize: 28,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Select your payment type",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            RadioListTile(
              value: 1,
              groupValue: cashOnDelivery,
              onChanged: (value) {
                setState(() {
                  cashOnDelivery = value;
                });
              },
              title: Text("Cash on delivery"),
              contentPadding: EdgeInsets.all(0),
            ),
            RadioListTile(
              value: 0,
              groupValue: cashOnDelivery,
              onChanged: (value) {
                setState(() {
                  cashOnDelivery = value;
                });
              },
              contentPadding: EdgeInsets.all(0),
              title: Text("Pay via card"),
            ),
            SizedBox(
              height: 250,
              child: Swiper(
                itemCount: 2,
                itemBuilder: (_, index) {
                  return CreditCard();
                },
                scale: 0.8,
                controller: swipeController,
                viewportFraction: 0.6,
                loop: false,
                fade: 0.7,
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () async {
                if (cashOnDelivery != null) {
                  await UserController.placeOrder(product, address, grandTotal,
                          cashOnDelivery.toString())
                      .then((value) {
                    if (value != null) {
                      if (value['success'] == '1') {
                        UserController.removeFromCart(pid: product.pid);
                        Navigator.of(context).popUntil(ModalRoute.withName(
                          MainPage.routeName,
                        ));
                      }
                    }
                  });
                }
              },
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                    gradient: mainButton,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.16),
                        offset: Offset(0, 5),
                        blurRadius: 10.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(9.0)),
                child: Center(
                  child: Text("Proceed",
                      style: const TextStyle(
                          color: const Color(0xfffefefe),
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontSize: 20.0)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
