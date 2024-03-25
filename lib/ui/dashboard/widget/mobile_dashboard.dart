import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/const/theme.dart';
import 'package:rg_track/model/event.dart';
import 'package:rg_track/ui/dashboard/widget/dashboard_chart_mobile.dart';
import 'package:rg_track/ui/dashboard/widget/map/dashboard_map_mobile.dart';
import 'package:rg_track/ui/widget/elavated.dart';
import 'package:rg_track/utils/date_utils.dart';

class MobileDashboard extends StatefulWidget {
  final List<Event> event;
  final int countGreenStatus;
  final int countYellowStatus;
  final int countRedStatus;
  const MobileDashboard({
    super.key,
    required this.event,
    required this.countGreenStatus,
    required this.countYellowStatus,
    required this.countRedStatus,
  });

  @override
  State<MobileDashboard> createState() => _WideDashState();
}

class _WideDashState extends State<MobileDashboard> {
  final Completer<GoogleMapController> _completer = Completer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          DashboardChartMobile(
            attention: widget.countRedStatus,
            ok: widget.countGreenStatus,
            warning: widget.countYellowStatus,
          ),
          const SizedBox(
            height: 15,
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
                        columns: const [
                          DataColumn(label: Text('LOCAL')),
                          DataColumn(label: Text('PLACA')),
                          DataColumn(label: Text('OCORRÊNCIA')),
                          DataColumn(label: Text('DATA')),
                        ],
                        rows: widget.event.isNotEmpty
                            ? widget.event.map((Event event) {
                                return DataRow(
                                  cells: [
                                    DataCell(Row(
                                      children: [
                                        Text(event.address ?? ''),
                                        IconButton(
                                          icon: Icon(
                                            MdiIcons.map,
                                            color: primaryColor,
                                          ),
                                          tooltip: 'Abrir mapa',
                                          onPressed: () => {
                                            showBottomSheet(
                                              backgroundColor: Colors.white,
                                              elevation: 10,
                                              enableDrag: false,
                                              constraints: BoxConstraints(
                                                  maxHeight:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.5),
                                              context: context,
                                              builder: (context) {
                                                return Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 40,
                                                      child: Center(
                                                        child: IconButton(
                                                          icon: const Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            size: 30,
                                                          ),
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: DashboardMapMobile(
                                                        completer: _completer,
                                                        event: event,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          },
                                        ),
                                      ],
                                    )),
                                    DataCell(Text(
                                        event.vehicle?.licensePlate ?? '')),
                                    DataCell(Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text((event.eventDescription ?? '') +
                                            ': ' +
                                            (event.value.toString() + '   ')),
                                      ],
                                    )),
                                    DataCell(Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(event.date == null
                                            ? ''
                                            : event.date!.formatDataDmy()),
                                        Text(event.date == null
                                            ? ''
                                            : ' ' +
                                                event.date!.formatDataHMS()),
                                      ],
                                    )),
                                  ],
                                );
                              }).toList()
                            : [
                                const DataRow(cells: [
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
