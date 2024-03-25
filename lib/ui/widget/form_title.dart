import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final EdgeInsets padding;

  const FormTitle(
    this.title, {
    super.key,
    this.subtitle,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.labelMedium,
          ),
          if (subtitle != null) Text(subtitle!),
        ],
      ),
    );
  }
}
