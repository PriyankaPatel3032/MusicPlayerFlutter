import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Comman {
  static Widget TextComman(String text, FontWeight textFontStyle,
      Color textColor, double textfontsize) {
    return Text(
      text,
      style: TextStyle(
          color: textColor, fontSize: textfontsize, fontWeight: textFontStyle),


    );
  }
}
