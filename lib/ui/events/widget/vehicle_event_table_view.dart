import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/vehicle_event.dart';
import 'package:rg_track/ui/widget/single_child_scroll_bar_view.dart';
import 'package:rg_track/utils/types.dart';

class VehicleEventsTableView extends StatelessWidget {
  final List<VehicleEvent> vehicleEvents;
  final ModelAction<VehicleEvent> onDeleteAction;
  final ModelAction<VehicleEvent> onShowAction;
  final ModelAction<VehicleEvent> onUpdateAction;

  const VehicleEventsTableView(
    this.vehicleEvents, {
    super.key,
    required this.onDeleteAction,
    required this.onShowAction,
    required this.onUpdateAction,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollBarView(
      child: DataTable(
        rows: List.generate(vehicleEvents.length, (int index) {
          final VehicleEvent vehicleEvent = vehicleEvents[index];
          return DataRow(
              key: ValueKey("vehicleEvent:${vehicleEvent.id}"),
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
                DataCell(Text(vehicleEvent.id?.toString() ?? '')),
                DataCell(Text(vehicleEvent.name ?? '')),
                DataCell(Text(vehicleEvent.description ?? '')),
                DataCell(Text(vehicleEvent.maxTime?.toString() ?? '')),
                DataCell(Text(vehicleEvent.alertCentral! ? "Sim" : "Não")),
                DataCell(Row(
                  children: [
                    IconButton(
                      onPressed: () => onDeleteAction(vehicleEvent),
                      icon: Icon(MdiIcons.close),
                      tooltip: 'Delete',
                    ),
                    IconButton(
                      onPressed: () => onShowAction(vehicleEvent),
                      icon: Icon(MdiIcons.eye),
                      tooltip: 'Visualizar',
                    ),
                    IconButton(
                      onPressed: () => onUpdateAction(vehicleEvent),
                      icon: Icon(MdiIcons.fileEdit),
                      tooltip: 'Editar',
                    ),
                  ],
                )),
              ]);
        }),
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('NOME')),
          DataColumn(label: Text('AVISAR CENTRAL')),
          DataColumn(label: Text('PRIORIDADE')),
          DataColumn(label: Text('AÇÕES')),
        ],
      ),
    );
  }
}
