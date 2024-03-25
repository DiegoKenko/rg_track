import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/driver.dart';
import 'package:rg_track/ui/widget/single_child_scroll_bar_view.dart';
import 'package:rg_track/utils/types.dart';

class DriversTableView extends StatelessWidget {
  final List<Driver> drivers;
  final ModelAction<Driver> onDeleteAction;
  final ModelAction<Driver> onShowAction;
  final ModelAction<Driver> onUpdateAction;

  const DriversTableView(
    this.drivers, {
    Key? key,
    required this.onDeleteAction,
    required this.onShowAction,
    required this.onUpdateAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollBarView(
      child: DataTable(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        rows: List.generate(drivers.length, (int index) {
          final Driver driver = drivers[index];
          return DataRow(
              key: ValueKey("driver:${driver.id}"),
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
                DataCell(Text(driver.id?.toString() ?? '')),
                DataCell(Text(driver.name ?? '')),
                DataCell(Text(driver.document ?? '')),
                DataCell(Text(driver.cnh ?? '')),
                DataCell(Text(driver.phone ?? '-')),
                //ToDo: atribuir cliente ao model user e mostrar aqui quando aplicavel
                const DataCell(Text('-')),
                DataCell(Row(
                  children: [
                    IconButton(
                      onPressed: () => onDeleteAction(driver),
                      icon: Icon(MdiIcons.close),
                      tooltip: 'Delete',
                    ),
                    IconButton(
                      onPressed: () => onShowAction(driver),
                      icon: Icon(MdiIcons.eye),
                      tooltip: 'Visualizar',
                    ),
                    IconButton(
                      onPressed: () => onUpdateAction(driver),
                      icon: Icon(MdiIcons.fileEdit),
                      tooltip: 'Editar',
                    ),
                  ],
                )),
              ]);
        }),
        columns: const [
          DataColumn(label: Text('ID'), numeric: true),
          DataColumn(label: Text('NOME')),
          DataColumn(label: Text('CPF')),
          DataColumn(label: Text('CNH')),
          DataColumn(label: Text('CONTATO')),
          DataColumn(label: Text('CLIENTE')),
          DataColumn(label: Text('AÇÕES')),
        ],
      ),
    );
  }
}
