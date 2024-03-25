import 'package:flutter/material.dart';
import 'package:rg_track/const/theme.dart';

class CardStatusDetailWidget extends StatelessWidget {
  const CardStatusDetailWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.iconColor,
  });
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: primaryColor.withOpacity(0.1),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      height: 80,
      width: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: primaryColor,
              fontSize: 9,
              fontWeight: FontWeight.bold,
              wordSpacing: 1,
              letterSpacing: 2,
            ),
          ),
          Icon(icon, color: iconColor, size: 20),
          Text(
            value.toUpperCase(),
            style: const TextStyle(color: primaryColor, fontSize: 9),
          ),
        ],
      ),
    );
  }
}
