import 'package:flutter/material.dart';
import 'package:rg_track/const/enum/enum_form_options.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/ui/customers/single/customer_form.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';

class StoreCustomerScreen extends StatelessWidget {
  const StoreCustomerScreen({Key? key, required this.customer})
      : super(key: key);
  final Customer customer;

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
        title: 'Novo Cliente',
        child:
            CustomerForm(formOption: EnumFormOption.CREATE, customer: customer),
      ),
    );
  }
}
