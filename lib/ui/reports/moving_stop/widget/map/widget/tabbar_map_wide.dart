import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/const/theme.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/model/vehicle_status.dart';
import 'package:rg_track/model/vehicle_trail.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_controller_cubit.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_moving_stop_cubit.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/widget/card_status_detail_widget.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/widget/card_trip_detail_widget.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/widget/text_item_trip_detail_widget.dart';
import 'package:rg_track/ui/widget/elavated.dart';

class TabBarMapWide extends StatefulWidget {
  const TabBarMapWide({
    super.key,
    required this.vehicle,
    required this.vehicleTrails,
    required this.vehicleStatus,
  });
  final List<VehicleTrail> vehicleTrails;
  final Vehicle vehicle;
  final VehicleStatus vehicleStatus;

  @override
  State<TabBarMapWide> createState() => _TabBarMapWideState();
}

class _TabBarMapWideState extends State<TabBarMapWide>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final ValueNotifier<int> selectionIndexNotifier = ValueNotifier(-1);

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Elevated(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade300),
          shape: BoxShape.rectangle,
        ),
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          children: [
            TabBar(
              indicatorWeight: 1,
              indicatorColor: Colors.red,
              labelColor: primaryColor.withOpacity(0.3),
              tabs: [
                Tab(
                  icon: Icon(
                    widget.vehicle.icon,
                  ),
                ),
                Tab(
                  icon: Icon(
                    MdiIcons.mapMarkerPath,
                    color: primaryColor,
                  ),
                ),
              ],
              controller: _tabController,
            ),
            Expanded(
              child: !widget.vehicle.isEmpty
                  ? TabBarView(
                      controller: _tabController,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              widget.vehicleStatus.positionLatitude != null &&
                                      widget.vehicleStatus.positionLongitude !=
                                          null
                                  ? InkWell(
                                      onTap: () {
                                        context
                                            .read<MapControllerCubit>()
                                            .animate(
                                                widget.vehicleStatus
                                                    .positionLatitude!,
                                                widget.vehicleStatus
                                                    .positionLongitude!);
                                      },
                                      child: CardStatusDetailWidget(
                                        title: 'Localizalição',
                                        icon: MdiIcons.locationEnter,
                                        value: 'Ver no mapa',
                                        iconColor: Colors.green,
                                      ),
                                    )
                                  : Container(),
                              widget.vehicleStatus.engineIgnitionStatus != null
                                  ? CardStatusDetailWidget(
                                      title: 'Ignição',
                                      icon: widget.vehicleStatus
                                              .engineIgnitionStatus!
                                          ? MdiIcons.engine
                                          : MdiIcons.engineOutline,
                                      value: widget.vehicleStatus
                                              .engineIgnitionStatus!
                                          ? "Ligado"
                                          : "Desligado",
                                      iconColor: widget.vehicleStatus
                                              .engineIgnitionStatus!
                                          ? Colors.green
                                          : Colors.red,
                                    )
                                  : Container(),
                              widget.vehicleStatus.engineBlockedStatus != null
                                  ? CardStatusDetailWidget(
                                      title: 'Bloqueio',
                                      icon: MdiIcons.engine,
                                      value: widget.vehicleStatus
                                              .engineBlockedStatus!
                                          ? "Bloqueado"
                                          : "Não bloqueado",
                                      iconColor: widget.vehicleStatus
                                              .engineBlockedStatus!
                                          ? Colors.red
                                          : Colors.green,
                                    )
                                  : Container(),
                              widget.vehicleStatus.gsmSignalLevel != null
                                  ? CardStatusDetailWidget(
                                      title: 'SINAL GPS',
                                      icon: MdiIcons.signal,
                                      value:
                                          '${widget.vehicleStatus.gsmSignalLevel!} %',
                                      iconColor: primaryColor,
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: ValueListenableBuilder(
                              valueListenable: selectionIndexNotifier,
                              builder: (context, valueIndex, _) {
                                return ListView.separated(
                                  separatorBuilder: ((context, index) {
                                    return const SizedBox(height: 4);
                                  }),
                                  itemCount: widget.vehicleTrails.length,
                                  itemBuilder: ((context, index) {
                                    index =
                                        widget.vehicleTrails.length - index - 1;
                                    return Elevated(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: valueIndex == index
                                                  ? secondaryColor
                                                  : primaryColor,
                                              width: valueIndex == index
                                                  ? 2.5
                                                  : 0.5),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (valueIndex == index) {
                                              selectionIndexNotifier.value = -1;
                                            } else {
                                              selectionIndexNotifier.value =
                                                  index;
                                            }
                                            context
                                                .read<MapMovingStopCubit>()
                                                .setTrail(
                                                  widget.vehicle,
                                                  widget.vehicleTrails,
                                                  widget.vehicleStatus,
                                                  selectionIndexNotifier.value,
                                                );
                                          },
                                          child: CardTripDetailWidget(
                                            details: [
                                              TextItemTripDetailWidget(
                                                  title: "Início",
                                                  value: widget
                                                      .vehicleTrails[index]
                                                      .startDateFormatted),
                                              TextItemTripDetailWidget(
                                                  title: "Fim",
                                                  value: widget
                                                      .vehicleTrails[index]
                                                      .endDateFormatted),
                                              TextItemTripDetailWidget(
                                                  title: "Duração",
                                                  value: widget
                                                      .vehicleTrails[index]
                                                      .durationFormatted),
                                              TextItemTripDetailWidget(
                                                  title: "Distância",
                                                  value: widget
                                                      .vehicleTrails[index]
                                                      .distanceFormatted),
                                              TextItemTripDetailWidget(
                                                  title: "Velocidade máxima",
                                                  value: widget
                                                      .vehicleTrails[index]
                                                      .maxSpeedFormatted),
                                              TextItemTripDetailWidget(
                                                  title: "Velocidade média",
                                                  value: widget
                                                      .vehicleTrails[index]
                                                      .averageSpeedFormatted),
                                            ],
                                            header: Column(
                                              children: [
                                                const Icon(Icons.route),
                                                Text((index + 1).toString()),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              }),
                        ),
                      ],
                    )
                  : TabBarView(
                      controller: _tabController,
                      children: [
                        Container(
                          child: const Center(
                            child: Text('Nenhum veículo selecionado'),
                          ),
                        ),
                        Container(
                          child: const Center(
                            child: Text('Nenhum veículo selecionado'),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
