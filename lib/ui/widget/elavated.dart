import 'package:flutter/material.dart';

class Elevated extends StatelessWidget {
  const Elevated({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      color: Colors.transparent,
      elevation: 5,
      child: child,
    );
  }
}
