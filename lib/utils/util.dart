import 'package:flutter/material.dart';

class AppColors {
  static const Color bgColor = Color(0xff101010);
  static const Color secondrycolor = Color(0xff202023);
  static const Color mgrey = Color(0xff9E9E9E);
}

TextStyle mTextStyle16(
    {Color mcolor = Colors.black, FontWeight mfontweight = FontWeight.normal}) {
  return TextStyle(
    fontFamily: 'mainFont',
    fontSize: 16,
    color: mcolor,
    fontWeight: mfontweight,
  );
}

TextStyle mTextStyle14(
    {Color mcolor = Colors.black, FontWeight mfontweight = FontWeight.normal}) {
  return TextStyle(
    fontFamily: 'mainFont',
    fontSize: 14,
    color: mcolor,
    fontWeight: mfontweight,
  );
}

TextStyle mTextStyle12(
    {Color mcolor = Colors.black, FontWeight mfontweight = FontWeight.normal}) {
  return TextStyle(
    fontFamily: 'mainFont',
    fontSize: 12,
    color: mcolor,
    fontWeight: mfontweight,
  );
}
