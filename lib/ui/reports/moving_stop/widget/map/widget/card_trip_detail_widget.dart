import 'package:flutter/material.dart';

class CardTripDetailWidget extends StatelessWidget {
  const CardTripDetailWidget(
      {super.key, required this.details, required this.header});
  final List<Widget> details;
  final Widget header;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          SizedBox(width: 30, child: header),
          Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(children: details, spacing: 5)),
          )
        ],
      ),
    );
  }
}
