import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/const/theme.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/ui/widget/card_cell.dart';
import 'package:rg_track/ui/widget/elavated.dart';
import 'package:rg_track/utils/types.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;
  final ModelAction<Customer> onDeleteAction;
  final ModelAction<Customer> onShowAction;
  final ModelAction<Customer> onUpdateAction;

  const CustomerCard(this.customer,
      {Key? key,
      required this.onDeleteAction,
      required this.onShowAction,
      required this.onUpdateAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, left: 10, right: 10),
      child: Elevated(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
              width: 0.5,
            ),
            gradient: const LinearGradient(
              stops: [0.0, 0.9],
              colors: [
                Color.fromARGB(255, 201, 201, 201),
                Colors.white,
              ],
            ),
          ),
          padding: const EdgeInsets.only(
              top: 16.0, left: 16.0, right: 16.0, bottom: 8),
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    CardCell('NOME', customer.bestName),
                    CardCell('CPF/CNPJ', customer.document!),
                    CardCell('TELEFONE', customer.bestPhoneNumber),
                    CardCell('STATUS', customer.status ?? ''),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => onDeleteAction(customer),
                    icon: Icon(MdiIcons.close),
                    color: primaryColor,
                    tooltip: 'Delete',
                  ),
                  IconButton(
                    onPressed: () => onUpdateAction(customer),
                    icon: Icon(MdiIcons.fileEdit),
                    color: primaryColor,
                    tooltip: 'Editar',
                  ),
                  IconButton(
                    onPressed: () => onShowAction(customer),
                    icon: Icon(MdiIcons.eye),
                    color: primaryColor,
                    tooltip: 'Visualizar',
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
