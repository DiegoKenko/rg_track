import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/const/theme.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_controller_cubit.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_moving_stop_cubit.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_moving_stop_state.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/widget/card_status_detail_widget.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/widget/card_trip_detail_widget.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/widget/moving_stop_map_mobile.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/widget/text_item_trip_detail_widget.dart';
import 'package:rg_track/ui/widget/alert_dialog_fails.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';
import 'package:rg_track/ui/widget/elavated.dart';

class MovingStopMapPageMobile extends StatefulWidget {
  const MovingStopMapPageMobile({super.key, required this.vehicle});
  final Vehicle vehicle;

  @override
  State<MovingStopMapPageMobile> createState() =>
      _MovingStopMapPageMobileState();
}

class _MovingStopMapPageMobileState extends State<MovingStopMapPageMobile>
    with TickerProviderStateMixin {
  final ValueNotifier<bool> bottomSheetNotifier = ValueNotifier(true);
  final ValueNotifier<int> selectionIndexNotifier = ValueNotifier(-1);
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: SizedBox(
          height: 30,
          child: AppLogo.horizontal(),
        ),
      ),
      body: AppBody(
        inherit: true,
        title: widget.vehicle.description,
        child: MovingStopMapMobile(
          vehicle: widget.vehicle,
        ),
      ),
      bottomSheet: BlocBuilder<MapMovingStopCubit, MapMovingStopState>(
          builder: (context, state) {
        Widget child = Container();
        if (state is MapMovingStopSuccessState) {
          child = Column(
            children: [
              TabBar(
                indicatorWeight: 1,
                indicatorColor: Colors.red,
                labelColor: primaryColor.withOpacity(0.3),
                tabs: [
                  Tab(
                    icon: Icon(
                      widget.vehicle.icon,
                      color: primaryColor,
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
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          state.vehicleStatus.positionLatitude != null &&
                                  state.vehicleStatus.positionLongitude != null
                              ? InkWell(
                                  onTap: () {
                                    context.read<MapControllerCubit>().animate(
                                        state.vehicleStatus.positionLatitude!,
                                        state.vehicleStatus.positionLongitude!);
                                  },
                                  child: CardStatusDetailWidget(
                                    title: 'Localizalição',
                                    icon: MdiIcons.locationEnter,
                                    value: 'Ver no mapa',
                                    iconColor: Colors.green,
                                  ),
                                )
                              : Container(),
                          state.vehicleStatus.engineIgnitionStatus != null
                              ? CardStatusDetailWidget(
                                  title: 'Ignição',
                                  icon:
                                      state.vehicleStatus.engineIgnitionStatus!
                                          ? MdiIcons.engine
                                          : MdiIcons.engineOutline,
                                  value:
                                      state.vehicleStatus.engineIgnitionStatus!
                                          ? "Ligado"
                                          : "Desligado",
                                  iconColor:
                                      state.vehicleStatus.engineIgnitionStatus!
                                          ? Colors.green
                                          : Colors.red,
                                )
                              : Container(),
                          state.vehicleStatus.engineBlockedStatus != null
                              ? CardStatusDetailWidget(
                                  title: 'Bloqueio',
                                  icon: MdiIcons.engine,
                                  value:
                                      state.vehicleStatus.engineBlockedStatus!
                                          ? "Bloqueado"
                                          : "Não bloqueado",
                                  iconColor:
                                      state.vehicleStatus.engineBlockedStatus!
                                          ? Colors.red
                                          : Colors.green,
                                )
                              : Container(),
                          state.vehicleStatus.gsmSignalLevel != null
                              ? CardStatusDetailWidget(
                                  title: 'SINAL GPS',
                                  icon: MdiIcons.signal,
                                  value:
                                      '${state.vehicleStatus.gsmSignalLevel!} %',
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
                                return const SizedBox(height: 6);
                              }),
                              itemCount: state.vehicleTrails.length,
                              itemBuilder: ((context, index) {
                                index = state.vehicleTrails.length - index - 1;
                                return Elevated(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: valueIndex == index
                                              ? secondaryColor
                                              : primaryColor,
                                          width:
                                              valueIndex == index ? 2.5 : 0.5),
                                      borderRadius: BorderRadius.circular(10),
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
                                                state.vehicle,
                                                state.vehicleTrails,
                                                state.vehicleStatus,
                                                selectionIndexNotifier.value,
                                              );
                                        },
                                        child: CardTripDetailWidget(
                                          details: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextItemTripDetailWidget(
                                                    title: "Início",
                                                    value: state
                                                        .vehicleTrails[index]
                                                        .startDateFormatted),
                                                TextItemTripDetailWidget(
                                                    title: "Fim",
                                                    value: state
                                                        .vehicleTrails[index]
                                                        .endDateFormatted),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextItemTripDetailWidget(
                                                    title: "Duração",
                                                    value: state
                                                        .vehicleTrails[index]
                                                        .durationFormatted),
                                                TextItemTripDetailWidget(
                                                    title: "Distância",
                                                    value: state
                                                        .vehicleTrails[index]
                                                        .distanceFormatted),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextItemTripDetailWidget(
                                                    title: "Velocidade máxima",
                                                    value: state
                                                        .vehicleTrails[index]
                                                        .maxSpeedFormatted),
                                                TextItemTripDetailWidget(
                                                    title: "Velocidade média",
                                                    value: state
                                                        .vehicleTrails[index]
                                                        .averageSpeedFormatted),
                                              ],
                                            ),
                                          ],
                                          header: Column(
                                            children: [
                                              const Icon(Icons.route),
                                              Text((index + 1).toString()),
                                            ],
                                          ),
                                        )),
                                  ),
                                );
                              }),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        if (state is MapMovingStopLoadingState) {
          child = const Center(
            child: CircularProgressIndicator(
              strokeWidth: 10,
              color: primaryColor,
            ),
          );
        }
        if (state is MapMovingStopErrorState) {
          child = AlertDialogFails(
            exception: state.error,
            actionEnable: false,
          );
        }
        return ValueListenableBuilder(
            valueListenable: bottomSheetNotifier,
            builder: (context, value, _) {
              return AnimatedContainer(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.5),
                  color: Colors.white,
                ),
                duration: const Duration(milliseconds: 400),
                height: value ? MediaQuery.of(context).size.height / 2.5 : 40,
                child: value
                    ? Column(
                        children: [
                          SizedBox(
                            height: 30,
                            child: Center(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  size: 30,
                                ),
                                onPressed: () =>
                                    bottomSheetNotifier.value = false,
                              ),
                            ),
                          ),
                          Expanded(child: child),
                        ],
                      )
                    : SizedBox(
                        height: 40,
                        child: Center(
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_drop_up,
                              size: 30,
                            ),
                            onPressed: () {
                              bottomSheetNotifier.value = true;
                            },
                          ),
                        ),
                      ),
              );
            });
      }),
    );
  }
}
