import 'package:flutter/material.dart';
import 'package:rg_track/const/enum/enum_form_options.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/ui/customers/single/customer_form.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';

class UpdateCustomerScreen extends StatefulWidget {
  final String? id;
  final Customer customer;

  const UpdateCustomerScreen({
    Key? key,
    this.id,
    required this.customer,
  }) : super(key: key);

  @override
  State<UpdateCustomerScreen> createState() => _UpdateCustomerScreenState();
}

class _UpdateCustomerScreenState extends State<UpdateCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: SizedBox(
          height: 30,
          child: AppLogo.horizontal(),
        ),
      ),
      body: AppBody(
        title: "alterar Cliente",
        child: CustomerForm(
          customer: widget.customer,
          formOption: EnumFormOption.UPDATE,
        ),
      ),
    );
  }
}
