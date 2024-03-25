import 'package:flutter/material.dart';

class RowOrColumn extends StatelessWidget {
  final RowOrColumnMode mode;
  final List<Widget> children;
  final bool removeExpanded;

  const RowOrColumn({
    Key? key,
    required this.mode,
    required this.children,
    this.removeExpanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (mode == RowOrColumnMode.row) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      );
    }
    return Column(
      children: children.map((Widget e) {
        if (removeExpanded && e is Expanded) return e.child;
        return e;
      }).toList(),
    );
  }
}

enum RowOrColumnMode { row, column }
