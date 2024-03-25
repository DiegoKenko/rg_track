import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/const/devices_supported.dart';
import 'package:rg_track/const/theme.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/ui/widget/card_cell.dart';
import 'package:rg_track/ui/widget/elavated.dart';

class DeviceCard extends StatelessWidget {
  final Device device;
  final Function(Device device) onDeleteAction;
  final Function(Device device) onShowAction;
  final Function(Device device) onUpdateAction;
  final Function(Device device) onCheckConnection;
  final Function(Device device) onShowConnectionConfiguration;

  const DeviceCard(
    this.device, {
    super.key,
    required this.onDeleteAction,
    required this.onShowAction,
    required this.onUpdateAction,
    required this.onCheckConnection,
    required this.onShowConnectionConfiguration,
  });

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      CardCell('MODELO', device.model!.description),
                      CardCell('MARCA', device.brand!.description),
                      const CardCell('DISPOSITIVO', ''),
                      CardCell('PLACA', device.vehicleId ?? ''),
                      CardCell('SIM CARD', device.simNumber ?? ''),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => onDeleteAction(device),
                      icon: Icon(MdiIcons.close),
                      color: primaryColor,
                      tooltip: 'Delete',
                    ),
                    IconButton(
                      onPressed: () => onUpdateAction(device),
                      icon: Icon(MdiIcons.fileEdit),
                      color: primaryColor,
                      tooltip: 'Editar',
                    ),
                    IconButton(
                      onPressed: () => onShowAction(device),
                      icon: Icon(MdiIcons.eye),
                      color: primaryColor,
                      tooltip: 'Visualizar',
                    ),
                    IconButton(
                      onPressed: () => onShowConnectionConfiguration(device),
                      icon: Icon(MdiIcons.tools),
                      color: primaryColor,
                      tooltip: 'Configurações do servidor',
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
