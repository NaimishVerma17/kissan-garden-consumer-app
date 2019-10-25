import 'package:flutter/material.dart';

abstract class Styles {
  static const Color primaryColor = Color(0xFF487473);

  static TextStyle pageTitleText() {
    return TextStyle(
        color: primaryColor,
        fontSize: 24.0,
        letterSpacing: 1.3,
        fontWeight: FontWeight.w800);
  }

  static TextStyle drawerItemsText() {
    return TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        letterSpacing: 1.2,
        fontWeight: FontWeight.w500);
  }
}
