import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/event.dart';
import 'package:rg_track/utils/types.dart';

class EventsDataTableSource extends DataTableSource {
  final List<Event> events;
  final ModelAction<Event> onShowAction;

  EventsDataTableSource(this.events, this.onShowAction);

  @override
  DataRow? getRow(int index) {
    if (index >= events.length) {
      return null;
    }
    final Event event = events[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        // DataCell(Text(event.licensePlate)),
        // DataCell(Text(event.when)),
        const DataCell(Row(
          children: [
            // Icon(MdiIcons.fromString(event.iconName)),
            Text(''),
          ],
        )),
        DataCell(IconButton(
            onPressed: () => onShowAction(event), icon: Icon(MdiIcons.eye)))
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => events.length;

  @override
  int get selectedRowCount => 2;
}
// DataTable(
// decoration: BoxDecoration(
// color: Colors.white,
// border: Border.all(color: Colors.grey.shade300),
// shape: BoxShape.rectangle,
// ),
// columns: const [
// DataColumn(label: Text('PLACA')),
// DataColumn(label: Text('OCORRÊNCIA')),
// DataColumn(label: Text('TIPO')),
// DataColumn(label: Text('AÇÃO')),
// ],
// rows: widget.events.map((event) {
// return DataRow(
// cells: [
// DataCell(Text(event.licensePlate)),
// DataCell(Text(event.when)),
// DataCell(Row(
// children: [
// Icon(MdiIcons.fromString(event.iconName)),
// Text(event.type),
// ],
// )),
// DataCell(
// IconButton(onPressed: () => widget.onShowAction(event), icon: Icon(MdiIcons.eye)))
// ],
// );
// }).toList())
