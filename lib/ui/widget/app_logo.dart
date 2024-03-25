import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final Map<String, String> _logo = {
    'vertical': 'assets/images/logo/rgtrack_vertical_light.png',
    'horizontal': 'assets/images/logo/rgtrack_horizontal_white.png',
  };
  final Map<String, String> _logoDark = {
    'vertical': 'assets/images/logo/rgtrack_vertical_dark.png',
    'horizontal': 'assets/images/logo/rgtrack_horizontal_white.png',
  };
  final String _current;

  AppLogo({Key? key})
      : _current = 'vertical',
        super(key: key);

  AppLogo.horizontal({Key? key})
      : _current = 'horizontal',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      return Image.asset(
        _logoDark[_current]!,
        cacheHeight: _current == "vertical" ? null : 40,
        cacheWidth: _current == "vertical" ? null : 176,
      );
    } else {
      return Image.asset(
        _logo[_current]!,
        cacheHeight: _current == "vertical" ? null : 40,
        cacheWidth: _current == "vertical" ? null : 176,
      );
    }
  }
}
