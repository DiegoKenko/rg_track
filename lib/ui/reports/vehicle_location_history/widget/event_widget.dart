import 'package:flutter/material.dart';
import 'package:rg_track/model/event.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:styled_text/styled_text.dart';

class EventWidget extends StatelessWidget {
  final Event event;
  final Vehicle vehicle;
  final ValueNotifier<int> focusedEvent;

  final void Function(Event event) onCenterAction;

  const EventWidget(
    this.event,
    this.vehicle, {
    required this.focusedEvent,
    required this.onCenterAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: focusedEvent,
      builder: (BuildContext context, int value, Widget? child) => ListTile(
        leading: const Stack(
          children: [],
        ),
        onTap: () {
          onCenterAction(event);
        },
        selected: value == event.id,
        title: FutureBuilder(
          key: ValueKey(event.id),
          future: () async {}(),
          initialData: "",
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            return StyledText(
              text: _renderText(snapshot),
              tags: {
                'bold': StyledTextTag(
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                'italic': StyledTextTag(
                    style: const TextStyle(fontStyle: FontStyle.italic)),
              },
            );
          },
        ),
        subtitle: const Text(
          '',
        ),
      ),
    );
  }

  String _renderText(AsyncSnapshot<Object?> snapshot) {
    return "";
  }
}

class Tile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String tooltip;

  const Tile({
    this.icon = Icons.battery_unknown,
    this.title = '',
    this.tooltip = '',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          Expanded(child: Text(title)),
        ],
      ),
    );
  }
}
