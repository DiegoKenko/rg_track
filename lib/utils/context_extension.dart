import 'package:flutter/material.dart';

import 'package:rg_track/utils/screen_utils.dart' as screen_utils;

extension MyContext on BuildContext {
  bool get isWideScreen => screen_utils.isWideScreen(this);

  /// Retorna um valor de acordo com o tamanho da tela
  /// [xxl] >= 1600
  /// [xl] >= 1440
  /// [l] >= 1280
  /// [m] >= 960
  /// [sm] >= 840
  /// [s] >= 600
  /// [xs] >= 480
  num? getWidthSize({
    num? xxl,
    num? xl,
    num? l,
    num? m,
    num? sm,
    num? s,
    num? xs,
  }) =>
      screen_utils.getWidthSize(
        this,
        xxl: xxl,
        xl: xl,
        l: l,
        m: m,
        sm: sm,
        s: s,
        xs: xs,
      );

  double? onWideScreen(double wideValue, double? normalValue) =>
      isWideScreen ? wideValue : normalValue;
}
