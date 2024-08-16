import 'package:ecommerce_int2/constants/colors.dart';
import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(IconData icons, String hinttext,
    {String? errorText}) {
  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.0),
    borderSide: BorderSide(
      color: Colors.blue,
      width: 1.5,
    ),
  );
  return InputDecoration(
    hintText: hinttext,
    prefixIcon: Icon(icons, color: AppColor.header),
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    errorText: errorText,
  );
}
