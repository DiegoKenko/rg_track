import 'package:flutter/material.dart';
import 'package:rg_track/const/devices_supported.dart';
import 'package:rg_track/model/device.dart';

class DeviceTile extends StatelessWidget {
  final Device device;

  const DeviceTile(this.device, {super.key});

  @override
  Widget build(BuildContext context) {
    String? description =
        '${device.brand?.description ?? ''} | ${device.model?.description ?? ''}';
    String imei = device.imeiFormatted;
    if (device.brand == null && device.model == null) {
      description = null;
      imei = 'Nenhum';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          imei,
          style: const TextStyle(fontSize: 14),
        ),
        description != null
            ? Text(
                description,
                style: const TextStyle(fontSize: 11),
              )
            : Container(),
      ],
    );
  }
}
