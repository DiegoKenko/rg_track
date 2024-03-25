import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/const/devices_supported.dart';
import 'package:rg_track/const/theme.dart';
import 'package:rg_track/ui/widget/elavated.dart';

import 'package:rg_track/model/device.dart';
import 'package:rg_track/ui/widget/single_child_scroll_bar_view.dart';

class DevicesTableView extends StatelessWidget {
  final List<Device> devices;
  final Function(Device device) onDeleteAction;
  final Function(Device device) onShowAction;
  final Function(Device device) onUpdateAction;
  final Function(Device device) onCheckConnection;
  final Function(Device device) onShowConnectionConfiguration;

  const DevicesTableView(
    this.devices, {
    super.key,
    required this.onDeleteAction,
    required this.onShowAction,
    required this.onUpdateAction,
    required this.onCheckConnection,
    required this.onShowConnectionConfiguration,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollBarView(
      child: Elevated(
        child: DataTable(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
          ),
          columns: const [
            DataColumn(
              label: Text('ID'),
            ),
            DataColumn(label: Text('MARCA')),
            DataColumn(label: Text('MODELO')),
            DataColumn(label: Text('IMEI')),
            DataColumn(label: Text('CHIP')),
            DataColumn(label: Text('AÇÕES')),
          ],
          rows: List.generate(devices.length, (int index) {
            final Device device = devices[index];
            return DataRow(
              key: ValueKey("device:${device.id}"),
              color:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered)) {
                  return Colors.grey.shade300;
                }
                return index.isEven
                    ? Colors.transparent
                    : Colors.grey.withOpacity(0.1);
              }),
              onLongPress: () {},
              cells: [
                DataCell(Text(device.id ?? '')),
                DataCell(Text(device.brand?.description ?? '')),
                DataCell(Text(device.model?.description ?? '')),
                DataCell(Text(device.imeiFormatted)),
                DataCell(Text(device.simNumber ?? '')),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => onDeleteAction(device),
                        icon: Icon(
                          MdiIcons.close,
                          color: deleteColor,
                        ),
                        tooltip: 'Delete',
                      ),
                      IconButton(
                        onPressed: () => onShowAction(device),
                        icon: Icon(MdiIcons.eye),
                        tooltip: 'Visualizar',
                      ),
                      IconButton(
                        onPressed: () => onUpdateAction(device),
                        icon: Icon(MdiIcons.fileEdit),
                        tooltip: 'Editar',
                      ),
                      /*   IconButton(
                        onPressed: () => onCheckConnection(device),
                        icon: Icon(MdiIcons.carConnected),
                        tooltip: 'Consultar status',
                      ), */
                      IconButton(
                        onPressed: () => onShowConnectionConfiguration(device),
                        icon: Icon(MdiIcons.tools),
                        tooltip: 'Configurações do servidor',
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
