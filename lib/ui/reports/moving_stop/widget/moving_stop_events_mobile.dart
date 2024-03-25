import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/const/theme.dart';
import 'package:rg_track/model/event.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/widget/elavated.dart';
import 'package:rg_track/utils/types.dart';

class MovingStopEventsMobile extends StatefulWidget {
  final List<Vehicle> vehicles;
  final ModelAction<Vehicle> onShowAction;
  final ModelAction<Event?> onCenterAction;
  final DateTime lastUpdate;
  final ValueNotifier<Vehicle?>? selectedVehicle;

  const MovingStopEventsMobile({
    required this.vehicles,
    required this.onShowAction,
    required this.onCenterAction,
    required this.lastUpdate,
    this.selectedVehicle,
    super.key,
  });

  @override
  State<MovingStopEventsMobile> createState() => _MovingStopEventsMobileState();
}

class _MovingStopEventsMobileState extends State<MovingStopEventsMobile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /*  TextField(
            controller: _searchCtrl,
            focusNode: _searchFocus,
            decoration: InputDecoration(
              isDense: true,
              hintMaxLines: 1,
              hintText: 'Qual veículo deseja encontrar?',
              suffixIcon: IconButton(
                padding: EdgeInsets.zero,
                tooltip: 'Limpar busca',
                color: Colors.grey,
                onPressed: () {
                  _searchCtrl.clear();
                  _searchFocus.unfocus();
                },
                icon: const Icon(Icons.clear),
              ),
            ),
            onChanged: (String value) {},
          ), */
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Elevated(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.white,
                    child: DataTable(
                        columnSpacing: 15,
                        headingTextStyle: const TextStyle(
                            letterSpacing: 1.5,
                            color: primaryColor,
                            fontSize: 15),
                        showBottomBorder: true,
                        columns: const [
                          DataColumn(label: Text('TIPO')),
                          DataColumn(label: Text('MAPA')),
                          DataColumn(label: Text('PLACA')),
                          DataColumn(label: Text('MODELO')),
                        ],
                        rows: widget.vehicles.isNotEmpty
                            ? widget.vehicles.map((Vehicle vehicle) {
                                return DataRow(
                                  cells: [
                                    DataCell(Tooltip(
                                      message: '',
                                      child: Icon(
                                        vehicle.icon,
                                      ),
                                    )),
                                    DataCell(
                                      IconButton(
                                        icon: Icon(MdiIcons.map),
                                        tooltip: 'Abrir mapa',
                                        onPressed: () =>
                                            widget.onShowAction(vehicle),
                                      ),
                                    ),
                                    DataCell(Text(vehicle.licensePlate ?? '')),
                                    DataCell(Text('${vehicle.manufacturer ?? ''} ${vehicle.model ?? ''}')),
                                  ],
                                );
                              }).toList()
                            : [
                                const DataRow(cells: [
                                  DataCell(Text('Nenhum veículo encontrado')),
                                  DataCell(Text('')),
                                  DataCell(Text('')),
                                  DataCell(Text('')),
                                  DataCell(Text('')),
                                ])
                              ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
