import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rg_track/model/event.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/reports/vehicle_location_history/cubit/location_history_cubit.dart';
import 'package:rg_track/ui/reports/vehicle_location_history/cubit/location_history_state.dart';
import 'package:rg_track/ui/reports/vehicle_location_history/cubit/location_vehicle_cubit.dart';
import 'package:rg_track/ui/reports/vehicle_location_history/cubit/location_vehicle_state.dart';
import 'package:rg_track/ui/reports/vehicle_location_history/widget/location_entries.dart';
import 'package:rg_track/ui/widget/app_logo.dart';
import 'package:rg_track/ui/widget/dynamic_divider.dart';
import 'package:rg_track/utils/screen_utils.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class VehicleLocationHistoryScreen extends StatefulWidget {
  static const String route = '/reports/vehicle-location-history';
  final String id;
  final Vehicle? vehicle;

  const VehicleLocationHistoryScreen({
    required this.id,
    this.vehicle,
    super.key,
  });

  @override
  State<VehicleLocationHistoryScreen> createState() =>
      _VehicleLocationHistoryScreenState();
}

class _VehicleLocationHistoryScreenState
    extends State<VehicleLocationHistoryScreen>
    with SingleTickerProviderStateMixin {
  late final LocationHistoryCubit _cubit;
  final ValueNotifier<int> _focusedEvent = ValueNotifier<int>(-1);
  final GlobalKey _mapKey =
      GlobalKey(debugLabel: 'vehicle-location-history-map');
  Vehicle? _vehicle;
  List<Event> _events = const [];

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  initState() {
    _vehicle = widget.vehicle;
    _cubit = context.read<LocationHistoryCubit>();
    _cubit.getVehicleLocationHistoryEvents(widget.vehicle?.id ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40,
          child: AppLogo.horizontal(),
        ),
        leading: context.canPop()
            ? null
            : BackButton(
                onPressed: () => context.go('/'),
                color: Colors.white,
              ),
      ),
      body: BlocBuilder<LocationVehicleListCubit, LocationVehicleState>(
        builder: (BuildContext context, LocationVehicleState state) {
          if (state is LocationVehicleInitial) {
            context
                .read<LocationVehicleListCubit>()
                .getVehicle(widget.id, widget.vehicle);
          }
          if (state is LocationVehicleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LocationVehicleLoaded) {
            _vehicle = state.vehicle;
          } else if (state is LocationVehicleError) {
            return Center(child: Text(state.message));
          }
          return BlocBuilder<LocationHistoryCubit, LocationHistoryState>(
            buildWhen:
                (LocationHistoryState previous, LocationHistoryState current) =>
                    current is LocationHistoryLoaded,
            builder: (BuildContext context, LocationHistoryState state) {
              _events = state is LocationHistoryLoaded ? state.events : _events;
              if (!isWideScreen(context)) {
                return SnappingSheet(
                  grabbing: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(8)),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  grabbingHeight: 36,
                  sheetBelow: SnappingSheetContent(
                    draggable: true,
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: LocationEntries(
                        events: _events,
                        focusedEvent: _focusedEvent,
                        mapKey: _mapKey,
                        vehicle: _vehicle!,
                        itemScrollController: itemScrollController,
                        itemPositionsListener: itemPositionsListener,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 36),
                    child: Container(),
                  ),
                );
              }
              return DynamicDivider(
                  dividerWidth: 15,
                  leftChildInitialRate: .75,
                  leftChildMinRate: 0.4,
                  leftChildMaxRate: 0.8,
                  rightChild: LocationEntries(
                    events: _events,
                    focusedEvent: _focusedEvent,
                    itemPositionsListener: itemPositionsListener,
                    itemScrollController: itemScrollController,
                    mapKey: _mapKey,
                    vehicle: _vehicle!,
                  ),
                  leftChild: Container());
            },
          );
        },
      ),
    );
  }
}
