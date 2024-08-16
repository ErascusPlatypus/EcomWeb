import 'package:flutter/material.dart';

class AddAddressForm extends StatelessWidget {
  final formKey;
  final TextEditingController flatNoController;
  final TextEditingController streetController;
  final TextEditingController nameController;
  final TextEditingController postCodeController;

  AddAddressForm(
    this.formKey,
    this.flatNoController,
    this.nameController,
    this.postCodeController,
    this.streetController,
  );
  @override
  Widget build(BuildContext context) {
    return Form(
      key: this.formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
            ),
            child: TextFormField(controller: flatNoController,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return "Please enter your Flat Number/House Number";
                }
                return null;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Flat Number/House Number'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
            ),
            child: TextFormField(
              controller: streetController,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return "Please enter your Street";
                }
                return null;
              },
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: 'Street'),
            ),
          ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.all(16.0),
          //       child: Text(
          //         'Area',
          //         style: TextStyle(fontSize: 12, color: darkGrey),
          //       ),
          //     ),
          //     ClipRRect(
          //       borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(5), topRight: Radius.circular(5)),
          //       child: Container(
          //         padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
          //         decoration: BoxDecoration(
          //           border: Border(
          //               bottom: BorderSide(color: Colors.orange, width: 2)),
          //           color: Colors.orange[100],
          //         ),
          //         child: TextField(
          //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          //           decoration: InputDecoration(
          //             border: InputBorder.none,
          //             hintText: 'Name on card',
          //             hintStyle:
          //                 TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          //           ),
          //         ),
          //       ),
          //     ),

          //   ],
          // ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
            ),
            child: TextFormField(controller: nameController,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return "Please enter your Name on card";
                }
                return null;
              },
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Name on card'),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            child: Container(
              margin: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.red, width: 1)),
                color: Colors.white,
              ),
              child: TextFormField(
                controller: postCodeController,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Please enter your Postal code";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Postal code'),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: true,
                onChanged: (_) {},
              ),
              Text('Add this to address bookmark')
            ],
          )
        ],
      ),
    );
  }
}
