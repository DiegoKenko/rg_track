import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/driver.dart';
import 'package:rg_track/ui/widget/card_cell.dart';
import 'package:rg_track/utils/types.dart';

class DriverCard extends StatelessWidget {
  final Driver driver;
  final ModelAction<Driver> onDeleteAction;
  final ModelAction<Driver> onShowAction;
  final ModelAction<Driver> onUpdateAction;

  const DriverCard(this.driver,
      {Key? key,
      required this.onDeleteAction,
      required this.onShowAction,
      required this.onUpdateAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 16.0, left: 16.0, right: 16.0, bottom: 8),
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    CardCell('USUÁRIO', driver.name!),
                    CardCell('CPF', driver.document!),
                    CardCell('CONTATO', driver.phone!),
                    CardCell('CLIENTE', driver.customer?.bestName ?? ''),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => onDeleteAction(driver),
                    icon: Icon(MdiIcons.close),
                    tooltip: 'Delete',
                  ),
                  IconButton(
                    onPressed: () => onUpdateAction(driver),
                    icon: Icon(MdiIcons.fileEdit),
                    tooltip: 'Editar',
                  ),
                  IconButton(
                    onPressed: () => onShowAction(driver),
                    icon: Icon(MdiIcons.eye),
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
