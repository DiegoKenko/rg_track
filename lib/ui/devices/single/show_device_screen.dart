import 'package:flutter/material.dart';
import 'package:rg_track/const/enum/enum_form_options.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/ui/devices/single/device_form.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';

class ShowDeviceScreen extends StatefulWidget {
  final Device device;

  const ShowDeviceScreen({
    super.key,
    required this.device,
  });

  @override
  State<ShowDeviceScreen> createState() => _ShowDeviceScreenState();
}

class _ShowDeviceScreenState extends State<ShowDeviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: SizedBox(
          height: 30,
          child: AppLogo.horizontal(),
        ),
      ),
      body: AppBody(
        title: 'DADOS DO EQUIPAMENTO',
        child: DeviceForm(
          device: widget.device,
          formOption: EnumFormOption.VIEW,
        ),
      ),
    );
  }
}
