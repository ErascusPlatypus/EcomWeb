import 'package:ecommerce_int2/app/user_and_seller/view/checkout/select_payment_method.dart';
import 'package:ecommerce_int2/helper/app_properties.dart';
import 'package:ecommerce_int2/helper/base.dart';
import 'package:ecommerce_int2/main.dart';
import 'package:flutter/material.dart';

import 'address_form.dart';

class AddAddressPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController flatNo = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController nameOnCard = TextEditingController();
  final TextEditingController postCode = TextEditingController();
  static final String routeName = '/add_address_page';

  @override
  Widget build(BuildContext context) {
    final data = context.extra['product'];
    var grandTotal = context.extra['grandTotal'];

    Widget finishButton = InkWell(
      onTap: () {
        if (_formKey.currentState?.validate() == true)
          launch(
            context,
            SelectPaymentMethod.routeName,
            {
              "product": data,
              "grandTotal": grandTotal,
              "address":
                  "${flatNo.text},${street.text}\n${nameOnCard.text},${postCode.text}"
            },
          );
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
          child: Text("Next",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: darkGrey),
        title: Text(
          'Add Address',
          style: const TextStyle(
              color: darkGrey,
              fontWeight: FontWeight.w500,
              fontFamily: "Montserrat",
              fontSize: 18.0),
        ),
      ),
      body: LayoutBuilder(
        builder: (_, viewportConstraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Container(
              padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: MediaQuery.of(context).padding.bottom == 0
                      ? 20
                      : MediaQuery.of(context).padding.bottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        color: Colors.white,
                        elevation: 3,
                        child: SizedBox(
                          height: 100,
                          width: 80,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Image.asset(
                                      'assets/icons/address_home.png'),
                                ),
                                Text(
                                  'Add New Address',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: darkGrey,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          launch(
                            context,
                            SelectPaymentMethod.routeName,
                            {
                              "product": data,
                              'address': 'SWork place',
                              "grandTotal": grandTotal,
                            },
                          ); // launch(context, PaymentPage.routeName, {});
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (_) => PaymentPage(),
                          //   ),
                          // );
                        },
                        child: Card(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            color: yellow,
                            elevation: 3,
                            child: SizedBox(
                                height: 80,
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Image.asset(
                                          'assets/icons/address_home.png',
                                          color: Colors.white,
                                          height: 20,
                                        ),
                                      ),
                                      Text(
                                        'Simon Philip,\nCity Oscarlad',
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ))),
                      ),
                      InkWell(
                        onTap: () {
                          launch(
                            context,
                            SelectPaymentMethod.routeName,
                            {
                              "product": data,
                              'address': 'Work place',
                              "grandTotal": grandTotal,
                            },
                          );
                        },
                        child: Card(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            color: yellow,
                            elevation: 3,
                            child: SizedBox(
                                height: 80,
                                width: 100,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Image.asset(
                                            'assets/icons/address_work.png',
                                            color: Colors.white,
                                            height: 20),
                                      ),
                                      Text(
                                        'Workplace',
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ))),
                      )
                    ],
                  ),
                  AddAddressForm(
                      _formKey, flatNo, street, nameOnCard, postCode),
                  Center(child: finishButton)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
