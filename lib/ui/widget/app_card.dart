import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget? header;
  final List<Widget>? actions;
  final List<Widget> cells;

  const AppCard({
    super.key,
    this.header,
    this.actions,
    required this.cells,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (header != null) header!,
              if (header != null) const Divider(),
              Row(
                children: [
                  Expanded(
                      child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: cells,
                  )),
                  Column(
                    children: actions ?? [],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
