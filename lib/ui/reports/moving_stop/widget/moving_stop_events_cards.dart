import 'package:flutter/material.dart';
import 'package:rg_track/model/event.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/events/widget/event_card.dart';
import 'package:rg_track/utils/types.dart';

class MovingStopEventsCards extends StatelessWidget {
  final List<Vehicle> vehicles;
  final ModelAction<Vehicle> onShowAction;
  final ModelAction<Event?> onCenterAction;
  final DateTime lastUpdate;
  final ValueNotifier<Vehicle?>? selectedVehicle;

  const MovingStopEventsCards({
    required this.vehicles,
    required this.onShowAction,
    required this.onCenterAction,
    required this.lastUpdate,
    this.selectedVehicle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      // onRefresh: context.read<MovingStopCubit>().getVehiclesWithEvents,
      onRefresh: () async {},
      child: ListView.builder(
        itemCount: vehicles.length,
        padding: const EdgeInsets.fromLTRB(32, 16, 32, 64),
        itemBuilder: (BuildContext context, int index) => EventCard(
          vehicle: vehicles[index],
          onShowAction: onShowAction,
          onCenterAction: onCenterAction,
          lastUpdate: lastUpdate,
          selectedVehicle: selectedVehicle,
        ),
      ),
    );
  }
}
