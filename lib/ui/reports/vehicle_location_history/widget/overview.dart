import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/event.dart';
import 'package:rg_track/model/vehicle.dart';

class Overview extends StatelessWidget {
  final List<Event> events;
  final Vehicle vehicle;

  const Overview(this.events, this.vehicle, {super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Resumo'),
      children: () {
        if (events.isEmpty) {
          return [
            Icon(
              MdiIcons.octagon,
              size: 75,
              color: Theme.of(context).disabledColor,
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                  child: Text(
                'Sem dados suficientes para gerar o resumo',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).disabledColor),
              )),
            ),
          ];
        }
        return [
          const ListTile(
            leading: Icon(Icons.directions_car),
            title: Text('Distância percorrida'),
            subtitle: Text(' km'),
          ),
          const ListTile(
            leading: Icon(Icons.timer),
            title: Text('Tempo'),
            subtitle: Wrap(
              runSpacing: 5,
              spacing: 10,
              children: [
                Text(' movimento'),
                Text(' ligado'),
                Text(''),
              ],
            ),
          ),
          const ListTile(
            leading: Icon(Icons.speed),
            title: Text('Velocidade em movimento'),
            subtitle: Wrap(
              runSpacing: 5,
              spacing: 10,
              children: [
                Text(''),
                Text(''),
                Text(''),
              ],
            ),
          ),
          const ListTile(
            leading: Icon(Icons.warning),
            title: Text('Problemas'),
            subtitle: Wrap(
              runSpacing: 5,
              spacing: 10,
              children: [
                Text(''),
              ],
            ),
          ),
        ];
      }(),
    );
  }
}
