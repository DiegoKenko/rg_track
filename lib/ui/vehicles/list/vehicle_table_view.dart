import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/widget/elavated.dart';
import 'package:rg_track/ui/widget/single_child_scroll_bar_view.dart';
import 'package:rg_track/utils/types.dart';

class VehiclesTableView extends StatelessWidget {
  final List<Vehicle> vehicles;
  final ModelAction<Vehicle> onDeleteAction;
  final ModelAction<Vehicle> onShowAction;
  final ModelAction<Vehicle> onUpdateAction;

  const VehiclesTableView(
    this.vehicles, {
    super.key,
    required this.onDeleteAction,
    required this.onShowAction,
    required this.onUpdateAction,
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
          ),
          rows: List.generate(vehicles.length, (int index) {
            final Vehicle vehicle = vehicles[index];
            return DataRow(
                key: ValueKey("vehicle:${vehicle.id}"),
                color: MaterialStateColor.resolveWith(
                    (Set<MaterialState> states) =>
                        index.isEven ? Colors.white : Colors.grey.shade100),
                cells: [
                  DataCell(Text(vehicle.simpleID)),
                  DataCell(Text(vehicle.licensePlate ?? '')),
                  DataCell(Text(vehicle.manufacturer ?? '')),
                  DataCell(Text(vehicle.model ?? '')),
                  DataCell(Text(vehicle.uf ?? '')),
                  DataCell(Row(
                    children: [
                      IconButton(
                        onPressed: () => onDeleteAction(vehicle),
                        icon: Icon(MdiIcons.close),
                        tooltip: 'Excluir',
                      ),
                      IconButton(
                        onPressed: () => onShowAction(vehicle),
                        icon: Icon(MdiIcons.eye),
                        tooltip: 'Visualizar',
                      ),
                      IconButton(
                        onPressed: () => onUpdateAction(vehicle),
                        icon: Icon(MdiIcons.fileEdit),
                        tooltip: 'Editar',
                      ),
                    ],
                  )),
                ]);
          }),
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('PLACA')),
            DataColumn(label: Text('MARCA')),
            DataColumn(label: Text('MODELO')),
            DataColumn(label: Text('UF')),
            DataColumn(label: Text('AÇÕES')),
          ],
        ),
      ),
    );
  }
}
