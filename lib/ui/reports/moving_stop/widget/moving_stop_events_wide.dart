import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/const/theme.dart';
import 'package:rg_track/model/event.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/widget/elavated.dart';
import 'package:rg_track/utils/types.dart';

class MovingStopEventsWide extends StatefulWidget {
  final List<Vehicle> vehicles;
  final ModelAction<Vehicle> onShowAction;
  final ModelAction<Event?> onCenterAction;
  final DateTime lastUpdate;
  final ValueNotifier<Vehicle?>? selectedVehicle;

  const MovingStopEventsWide({
    required this.vehicles,
    required this.onShowAction,
    required this.onCenterAction,
    required this.lastUpdate,
    this.selectedVehicle,
    super.key,
  });

  @override
  State<MovingStopEventsWide> createState() => _MovingStopEventsWideState();
}

class _MovingStopEventsWideState extends State<MovingStopEventsWide> {
/*   final TextEditingController _searchCtrl = TextEditingController();
  final FocusNode _searchFocus = FocusNode(); */
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        /*   Padding(
          padding: const EdgeInsets.only(top: 60, bottom: 5, right: 16),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 300, maxHeight: 50),
            child: TextField(
              controller: _searchCtrl,
              focusNode: _searchFocus,
              decoration: InputDecoration(
                enabled: false,
                hintText: 'Qual veículo deseja encontrar?',
                isDense: true,
                suffix: IconButton(
                  padding: EdgeInsets.zero,
                  tooltip: 'Limpar busca',
                  visualDensity: VisualDensity.compact,
                  color: Colors.grey,
                  onPressed: () {
                    _searchCtrl.clear();
                    _searchFocus.unfocus();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
              onChanged: (String value) {},
            ),
          ),
        ), */
        Elevated(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade300),
              shape: BoxShape.rectangle,
            ),
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  headingRowColor:
                      MaterialStateColor.resolveWith((states) => Colors.white),
                  showBottomBorder: true,
                  headingTextStyle: const TextStyle(
                      letterSpacing: 1.5, color: primaryColor, fontSize: 15),
                  columns: const [
                    DataColumn(label: Text('TIPO')),
                    DataColumn(label: Text('MAPA')),
                    DataColumn(label: Text('DESCRIÇÃO')),
                    DataColumn(label: Text('FABRICANTE')),
                    DataColumn(label: Text('PLACA')),
                  ],
                  rows: widget.vehicles.map((Vehicle vehicle) {
                    return DataRow(
                      cells: [
                        DataCell(Tooltip(
                          message: '',
                          child: Icon(
                            vehicle.icon,
                            color: vehicle.iconColor,
                          ),
                        )),
                        DataCell(
                          IconButton(
                            icon: Icon(MdiIcons.map),
                            tooltip: 'Abrir mapa',
                            onPressed: () => widget.onShowAction(vehicle),
                          ),
                        ),
                        DataCell(Text(vehicle.description)),
                        DataCell(Text(vehicle.manufacturer ?? '')),
                        DataCell(Text(vehicle.licensePlate ?? '')),
                      ],
                    );
                  }).toList()),
            ),
          ),
        ),
      ],
    );
  }
}
