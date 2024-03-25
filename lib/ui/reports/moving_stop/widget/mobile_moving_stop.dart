import 'package:flutter/material.dart';
import 'package:rg_track/model/event.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/route.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/moving_stop_events_mobile.dart';
import 'package:rg_track/utils/go_route_extension.dart';

class MobileMovingStop extends StatefulWidget {
  final DateTime lastUpdate;
  final List<Vehicle> vehicles;

  const MobileMovingStop({
    super.key,
    required this.lastUpdate,
    required this.vehicles,
  });

  @override
  State<MobileMovingStop> createState() => _WideDashState();
}

class _WideDashState extends State<MobileMovingStop> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MovingStopEventsMobile(
        lastUpdate: widget.lastUpdate,
        vehicles: widget.vehicles,
        onShowAction: (vehicle) {
          routeMovingStopMap.pushId(context, vehicle.id, vehicle);
        },
        onCenterAction: (Event? model) {},
        selectedVehicle: null,
      ),
    );
  }
}
