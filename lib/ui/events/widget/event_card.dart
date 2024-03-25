import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ms_list_utils/ms_list_utils.dart';
import 'package:rg_track/model/event.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/widget/app_card.dart';
import 'package:rg_track/ui/widget/card_cell.dart';
import 'package:rg_track/utils/types.dart';

class EventCard extends StatelessWidget {
  final Vehicle vehicle;
  final ModelAction<Vehicle> onShowAction;
  final ModelAction<Event?> onCenterAction;
  final DateTime lastUpdate;
  final ValueNotifier<Vehicle?>? selectedVehicle;

  const EventCard({
    super.key,
    required this.vehicle,
    required this.onShowAction,
    required this.onCenterAction,
    required this.lastUpdate,
    this.selectedVehicle,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      cells: [
        Tooltip(
          message: '',
          child: Icon(
            vehicle.icon,
          ),
        ),
        CardCell('FABRICANTE', vehicle.manufacturer ?? ''),
        CardCell('PLACA', vehicle.licensePlate ?? ''),
        FutureBuilder(
          future: () async {}(),
          initialData: "${vehicle.events.firstOrNull?.lat.toString() ?? '0'}, "
              "${vehicle.events.firstOrNull?.lng.toString() ?? '0'}",
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            return CardCell('LOCALIZAÇÃO', snapshot.data.toString());
          },
        ),
      ],
      actions: [
        IconButton(
          icon: Icon(MdiIcons.mapMarker),
          onPressed: () => onCenterAction(vehicle.events.firstOrNull),
          tooltip: 'Centralizar no mapa',
        ),
        if (selectedVehicle != null)
          ValueListenableBuilder<Vehicle?>(
              valueListenable: selectedVehicle!,
              builder: (BuildContext context, Vehicle? value, _) => IconButton(
                    tooltip: 'Acompanhar',
                    icon: value?.id == vehicle.id
                        ? Icon(MdiIcons.crosshairsGps)
                        : Icon(MdiIcons.crosshairs),
                    onPressed: () {
                      selectedVehicle!.value =
                          value?.id == vehicle.id ? null : vehicle;
                      if (selectedVehicle?.value != null) {
                        onCenterAction(vehicle.events.firstOrNull);
                      }
                    },
                    isSelected: false,
                  )),
        IconButton(
          icon: Icon(MdiIcons.eye),
          tooltip: 'Trajeto',
          onPressed: () => onShowAction(vehicle),
        ),
      ],
    );
  }
}
