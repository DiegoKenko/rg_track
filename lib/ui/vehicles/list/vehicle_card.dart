import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/const/theme.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/widget/card_cell.dart';
import 'package:rg_track/ui/widget/elavated.dart';
import 'package:rg_track/utils/types.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final ModelAction<Vehicle> onDeleteAction;
  final ModelAction<Vehicle> onShowAction;
  final ModelAction<Vehicle> onUpdateAction;

  const VehicleCard(this.vehicle,
      {super.key,
      required this.onDeleteAction,
      required this.onShowAction,
      required this.onUpdateAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
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
                Color.fromARGB(255, 231, 231, 231),
                Colors.white,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Icon(
                              vehicle.icon,
                              color: activeColor,
                            ),
                          ],
                        ),
                      ),
                      CardCell(
                          'PLACA', vehicle.licensePlate?.toUpperCase() ?? ''),
                      CardCell(
                          'MARCA', vehicle.manufacturer?.toUpperCase() ?? '-'),
                      CardCell('MODELO', vehicle.model?.toUpperCase() ?? '-'),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () => onDeleteAction(vehicle),
                      icon: Icon(MdiIcons.close),
                      tooltip: 'Delete',
                    ),
                    IconButton(
                      onPressed: () => onUpdateAction(vehicle),
                      icon: Icon(MdiIcons.fileEdit),
                      tooltip: 'Editar',
                    ),
                    IconButton(
                      onPressed: () => onShowAction(vehicle),
                      icon: Icon(MdiIcons.eye),
                      tooltip: 'Visualizar',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
