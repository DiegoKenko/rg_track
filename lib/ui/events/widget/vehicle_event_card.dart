import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/vehicle_event.dart';
import 'package:rg_track/ui/widget/card_cell.dart';
import 'package:rg_track/utils/types.dart';

class VehicleEventCard extends StatelessWidget {
  final VehicleEvent driver;
  final ModelAction<VehicleEvent> onDeleteAction;
  final ModelAction<VehicleEvent> onShowAction;
  final ModelAction<VehicleEvent> onUpdateAction;

  const VehicleEventCard(this.driver,
      {super.key,
      required this.onDeleteAction,
      required this.onShowAction,
      required this.onUpdateAction});

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
                    CardCell('NOME', driver.name!),
                    CardCell('DESCRIÇÃO', driver.description!),
                    CardCell(
                        'AVISAR CENTRAL', driver.alertCentral! ? "Sim" : "Não"),
                    CardCell('PRIORIDADE', driver.maxTime!.toString()),
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
