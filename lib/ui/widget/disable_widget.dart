import 'package:flutter/material.dart';

class Disable extends StatelessWidget {
  const Disable({
    super.key,
    required this.child,
    this.disable = true,
    this.absorbPointer = true,
  });
  final Widget child;
  final bool disable;
  final bool absorbPointer;

  @override
  Widget build(BuildContext context) {
    return disable
        ? AbsorbPointer(
            absorbing: absorbPointer,
            child: Opacity(
              opacity: 0.3,
              child: child,
            ),
          )
        : child;
  }
}
