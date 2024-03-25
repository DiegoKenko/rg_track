import 'package:flutter/material.dart';
import 'package:rg_track/model/customer.dart';

class CustomersDropdown extends StatefulWidget {
  final Customer customer;

  const CustomersDropdown({super.key, required this.customer});

  @override
  State<CustomersDropdown> createState() => _CustomersDropdownState();
}

class _CustomersDropdownState extends State<CustomersDropdown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF979797)),
      ),
      child: SizedBox(
        width: double.infinity,
        child: DropdownButton<String>(
          onChanged: (String? value) {},
          underline: const SizedBox(),
          alignment: AlignmentDirectional.centerEnd,
          isExpanded: true,
          hint: const Text('Selecionar Cliente'),
          value: '',
          items: <String>[].map((String s) {
            return DropdownMenuItem<String>(
              value: s,
              child: Text(s),
            );
          }).toList(),
        ),
      ),
    );
  }
}
