import 'package:flutter/material.dart';
import 'package:rg_track/model/customer.dart';

class CustomerTile extends StatelessWidget {
  final Customer customer;

  const CustomerTile(this.customer, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          customer.fullName ?? 'Nenhum',
          style: const TextStyle(fontSize: 14),
        ),
        customer.document != null
            ? Text(
                customer.document!,
                style: const TextStyle(fontSize: 11),
              )
            : Container(),
      ],
    );
  }
}
