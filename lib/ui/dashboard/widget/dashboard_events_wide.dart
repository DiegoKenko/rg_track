import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/const/theme.dart';
import 'package:rg_track/model/event.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/widget/elavated.dart';
import 'package:rg_track/utils/date_utils.dart';
import 'package:rg_track/utils/types.dart';

class DashboardEventsWide extends StatefulWidget {
  final List<Event> events;
  final ModelAction<Event?> onCenterAction;
  final DateTime lastUpdate;
  final ValueNotifier<Vehicle?>? selectedVehicle;

  const DashboardEventsWide({
    required this.events,
    required this.onCenterAction,
    required this.lastUpdate,
    this.selectedVehicle,
    super.key,
  });

  @override
  State<DashboardEventsWide> createState() => _DashboardEventsWideState();
}

class _DashboardEventsWideState extends State<DashboardEventsWide> {
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

        Expanded(
          child: Elevated(
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
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      showBottomBorder: true,
                      headingTextStyle: const TextStyle(
                          letterSpacing: 1.5,
                          color: primaryColor,
                          fontSize: 15),
                      columns: const [
                        DataColumn(label: Text('LOCAL')),
                        DataColumn(label: Text('PLACA')),
                        DataColumn(label: Text('OCORRÊNCIA')),
                        DataColumn(label: Text('')),
                        DataColumn(label: Text('DATA')),
                        DataColumn(label: Text('HORA')),
                      ],
                      rows: widget.events.map((Event e) {
                        return DataRow(
                          cells: [
                            DataCell(Row(
                              children: [
                                Text(e.address ?? ''),
                                IconButton(
                                  icon: Icon(MdiIcons.map),
                                  tooltip: 'Abrir mapa',
                                  onPressed: () => widget.onCenterAction(e),
                                ),
                              ],
                            )),
                            DataCell(Text(e.vehicle?.licensePlate ?? '')),
                            DataCell(Text(e.eventDescription ?? '')),
                            DataCell(Text(' ' + e.value.toString() + ' ')),
                            DataCell(Text(
                                e.date == null ? '' : e.date!.formatDataDmy())),
                            DataCell(Text(
                                e.date == null ? '' : e.date!.formatDataHMS())),
                          ],
                        );
                      }).toList()),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
