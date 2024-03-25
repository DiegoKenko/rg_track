import 'package:flutter/material.dart';
import 'package:rg_track/const/theme.dart';

class CardCell extends StatelessWidget {
  const CardCell(
    this.title,
    this.content, {
    Key? key,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: primaryColor),
          ),
        ],
      );
}
