import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color mainblue = Color(0xff04556F);
Color mainscaffold = Color(0xff1D1A1A);
Color offwhite = Color(0xFFE9E9E9);

SizedBox verticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

SizedBox horizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

TextStyle regularTextStyle(double fontsize) {
  return GoogleFonts.rubik(
  textStyle : TextStyle(
    fontSize: fontsize,
    fontWeight: FontWeight.w400,
    color: Color(0xffE9E9E9),
    )
  );
}

TextStyle boldTextStyle(double fontsize) {
  return GoogleFonts.rubik(
  textStyle : TextStyle(
    fontSize: fontsize,
    fontWeight: FontWeight.w800,
    color: Color(0xffE9E9E9),
    )
  );
}

BoxShadow containerboxshadow() {
  return BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.35),
      offset: Offset(2, 2),
      spreadRadius: 1,
      blurRadius: 1.5);
}

