import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ms_list_utils/ms_list_utils.dart';
import 'package:rg_track/model/event.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/reports/vehicle_location_history/cubit/location_history_cubit.dart';
import 'package:rg_track/ui/reports/vehicle_location_history/cubit/location_history_state.dart';
import 'package:rg_track/ui/reports/vehicle_location_history/widget/event_widget.dart';
import 'package:rg_track/ui/reports/vehicle_location_history/widget/overview.dart';
import 'package:rg_track/utils/date_utils.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class LocationEntries extends StatefulWidget {
  final List<Event> events;
  final ValueNotifier<int> focusedEvent;
  final GlobalKey mapKey;
  final Vehicle vehicle;
  final ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener;

  const LocationEntries({
    required this.events,
    required this.focusedEvent,
    required this.mapKey,
    required this.vehicle,
    required this.itemScrollController,
    required this.itemPositionsListener,
    super.key,
  });

  @override
  State<LocationEntries> createState() => _LocationEntriesState();
}

class _LocationEntriesState extends State<LocationEntries> {
  final ValueNotifier<bool> _isPlaying = ValueNotifier<bool>(false);
  final ValueNotifier<int> _focusedEvent = ValueNotifier<int>(-1);
  Timer? _timer;

  Event get _event => widget.events[_focusedEvent.value];

  @override
  Widget build(BuildContext context) {
    final LocationHistoryCubit cubit = context.read<LocationHistoryCubit>();
    return BlocBuilder<LocationHistoryCubit, LocationHistoryState>(
      builder: (BuildContext context, LocationHistoryState state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      cubit.getVehicleLocationHistoryEvents(
                          widget.vehicle.id.toString(),
                          widget.events.firstOrNull?.date);
                    },
                    icon: const Icon(Icons.arrow_back)),
                TextButton(
                    onPressed: () async {
                      final DateTime? date = await showDatePicker(
                          context: context,
                          initialDate:
                              widget.events.first.date ?? DateTime.now(),
                          firstDate: DateTime(2022, 10, 1),
                          lastDate: DateTime.now());
                      if (date == null) return;
                      cubit.getVehicleLocationHistoryEvents(
                          widget.vehicle.id.toString(), date);
                    },
                    child: Text(
                        formatDataDMY(widget.events.firstOrNull?.date) ?? "")),
                IconButton(
                    onPressed: () {
                      cubit.getVehicleLocationHistoryEvents(
                          widget.vehicle.id.toString(),
                          widget.events.firstOrNull?.date);
                    },
                    icon: const Icon(Icons.arrow_forward)),
              ],
            ),
            Overview(widget.events, widget.vehicle),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ScrollablePositionedList.builder(
                      itemScrollController: widget.itemScrollController,
                      itemPositionsListener: widget.itemPositionsListener,
                      reverse: true,
                      padding: const EdgeInsets.all(16),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: widget.events.length,
                      itemBuilder: (BuildContext context, int index) =>
                          EventWidget(
                        widget.events[index],
                        widget.vehicle,
                        onCenterAction: (Event event) {
                          widget.focusedEvent.value = event.id;
                          _focusedEvent.value = index;
                        },
                        focusedEvent: widget.focusedEvent,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: _previous,
                          icon: Icon(MdiIcons.skipPrevious),
                          tooltip: "Anterior"),
                      ValueListenableBuilder<bool>(
                        valueListenable: _isPlaying,
                        builder:
                            (BuildContext context, bool value, Widget? child) =>
                                IconButton(
                                    onPressed: _playPause,
                                    iconSize: 48,
                                    icon: value
                                        ? Icon(MdiIcons.pauseCircleOutline)
                                        : Icon(MdiIcons.playCircleOutline),
                                    tooltip: value ? "Iniciar" : "Pausar"),
                      ),
                      IconButton(
                          onPressed: _next,
                          icon: Icon(MdiIcons.skipNext),
                          tooltip: "Próximo"),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _focusedEvent.addListener(() {
      if (_focusedEvent.value >= 0) {
        widget.itemScrollController.scrollTo(
          index: _focusedEvent.value,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );

        widget.focusedEvent.value = _event.id;
      }
    });
    super.initState();
  }

  void _next() {
    if (widget.events.length > _focusedEvent.value + 1) {
      _focusedEvent.value++;
    }
  }

  void _pause() {
    _timer?.cancel();
    _isPlaying.value = false;
  }

  void _reset() {
    _focusedEvent.value = -1;
  }

  void _play() {
    _isPlaying.value = true;
    _timer = Timer.periodic(const Duration(milliseconds: 1500), (Timer timer) {
      if (_focusedEvent.value + 1 >= widget.events.length) {
        _reset();
      } else {
        _next();
      }
    });
  }

  void _playPause() {
    if (_isPlaying.value) {
      _pause();
    } else {
      _play();
    }
  }

  void _previous() {
    if (_focusedEvent.value < 0) {
      return;
    }
    _focusedEvent.value--;
  }
}
