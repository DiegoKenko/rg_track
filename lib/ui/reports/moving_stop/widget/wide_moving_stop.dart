import 'package:flutter/material.dart';
import 'package:rg_track/model/event.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/widget/moving_stop_map_wide.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/moving_stop_events_wide.dart';

class WideMovingStop extends StatefulWidget {
  final DateTime lastUpdate;
  final List<Vehicle> vehicles;

  const WideMovingStop({
    super.key,
    required this.lastUpdate,
    required this.vehicles,
  });

  @override
  State<WideMovingStop> createState() => _WideMovingStopState();
}

class _WideMovingStopState extends State<WideMovingStop> {
  ValueNotifier<Vehicle?> vehicleSelected = ValueNotifier(null);

  final ValueNotifier<int> selectionIndexNotifier = ValueNotifier(-1);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: MovingStopEventsWide(
              lastUpdate: widget.lastUpdate,
              vehicles: widget.vehicles,
              onShowAction: (vehicle) {
                vehicleSelected.value = vehicle;
              },
              onCenterAction: (Event? model) {},
              selectedVehicle: null,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 3,
            child: ValueListenableBuilder(
              valueListenable: vehicleSelected,
              builder: (context, state, _) {
                return MovingStopMapWide(
                  vehicle: state ?? Vehicle(userId: ''),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
