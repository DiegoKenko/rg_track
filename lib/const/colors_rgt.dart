import 'package:flutter/material.dart';

class ColorsRgt {
  ColorsRgt._();

  static const Color primaryColor = Color(0xFF1d2470);
  static const Color informative = Color(0xFF1d2470);
  static const Color error = Color(0xFFD2232A);
  static const Color success = Color(0xFF009C6D);
  static const Color warning = Color(0xFFE5A800);
  static const Color backgroundColor = Color(0xFFE5E5E5);
  static const Color white = Colors.white;

  static const Color text = Color(0xFF333333);
  static const Color textLight = Color(0xFF605D5C);
  static const Color textOnPrimary = Colors.white;
}

class ColorsVehicle {
  ColorsVehicle._();

  static const Color iconDriving = Color(0xFF009C6D);
  static const Color onIconDriving = ColorsRgt.backgroundColor;

  static const Color iconIdle = Color(0x80009C6D);
  static const Color onIconIdle = ColorsRgt.backgroundColor;

  static const Color iconParking = Color(0xFF605D5C);
  static const Color onIconParking = ColorsRgt.backgroundColor;

  static const Color iconAlert = Color(0xFFD2232A);
  static const Color onIconAlert = ColorsRgt.backgroundColor;

  static const Color unknown = Color(0xFF333333);
  static const Color onUnknown = ColorsRgt.backgroundColor;
}
