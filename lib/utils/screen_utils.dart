import 'package:flutter/material.dart';

bool isWideScreen(BuildContext context) => MediaQuery.of(context).size.width > 840;

/// Retorna um valor de acordo com o tamanho da tela
/// [xxl] >= 1600
/// [xl] >= 1440
/// [l] >= 1280
/// [m] >= 960
/// [sm] >= 840
/// [s] >= 600
/// [xs] >= 480
num? getWidthSize(
  BuildContext context, {
  num? xxl,
  num? xl,
  num? l,
  num? m,
  num? sm,
  num? s,
  num? xs,
}) {
  // assert([xxl, xl, l, m, sm, s, xs].every((element) => element != null),
  //     'Ao menos um valor deve ser declarado');
  if (MediaQuery.of(context).size.width >= 1600 && xxl != null) return xxl;
  if (MediaQuery.of(context).size.width >= 1440 && xl != null) return xl;
  if (MediaQuery.of(context).size.width >= 1280 && l != null) return l;
  if (MediaQuery.of(context).size.width >= 960 && m != null) return m;
  if (MediaQuery.of(context).size.width >= 840 && sm != null) return sm;
  if (MediaQuery.of(context).size.width >= 600 && s != null) return s;
  if (MediaQuery.of(context).size.width >= 480 && xs != null) return xs;
  return null;
}
