import 'package:flutter/material.dart';
import 'package:rg_track/const/theme.dart';

class TextItemTripDetailWidget extends StatelessWidget {
  const TextItemTripDetailWidget({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            title.toUpperCase() + ' : ',
            style: const TextStyle(
                color: primaryColor, fontSize: 13, fontWeight: FontWeight.bold),
          ),
          Text(value,
              style: const TextStyle(color: Colors.black, fontSize: 13)),
        ],
      ),
    );
  }
}
