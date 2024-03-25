import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rg_track/model/event.dart';
import 'package:rg_track/ui/dashboard/widget/dashboard_chart_wide.dart';
import 'package:rg_track/ui/dashboard/widget/dashboard_events_wide.dart';
import 'package:rg_track/ui/dashboard/widget/dashboard_pie_chart.dart';
import 'package:rg_track/ui/dashboard/widget/map/dashboard_map_wide.dart';
import 'package:rg_track/ui/widget/elavated.dart';

class WideDashboard extends StatefulWidget {
  final List<Event> events;
  final int countGreenStatus;
  final int countYellowStatus;
  final int countRedStatus;

  const WideDashboard({
    super.key,
    required this.events,
    required this.countGreenStatus,
    required this.countYellowStatus,
    required this.countRedStatus,
  });

  @override
  State<WideDashboard> createState() => Wide_Dashboard();
}

class Wide_Dashboard extends State<WideDashboard> {
  ValueNotifier<Event?> eventSelected = ValueNotifier(null);

  final ValueNotifier<int> selectionIndexNotifier = ValueNotifier(-1);
  final Completer<GoogleMapController> _completer = Completer();

  Future<void> _animateTo(double lat, double lng) async {
    final c = await _completer.future;
    final p = CameraPosition(target: LatLng(lat, lng), zoom: 16);
    c.animateCamera(CameraUpdate.newCameraPosition(p));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Elevated(
                      child: DashboardPieChart(
                        attention: widget.countRedStatus,
                        ok: widget.countGreenStatus,
                        warning: widget.countYellowStatus,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    DashboardChartWide(
                      attention: widget.countRedStatus,
                      ok: widget.countGreenStatus,
                      warning: widget.countYellowStatus,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: DashboardEventsWide(
                        events: widget.events,
                        onCenterAction: (a) {
                          if (a?.lat != null && a?.lng != null) {
                            _animateTo(a!.lat!, a.lng!);
                            eventSelected.value = a;
                          }
                        },
                        lastUpdate: DateTime.now()),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 3,
            child: ValueListenableBuilder(
              valueListenable: eventSelected,
              builder: (context, state, _) {
                return DashboardMapWide(
                  completer: _completer,
                  event: state,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
