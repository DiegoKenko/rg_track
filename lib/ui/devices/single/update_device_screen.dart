import 'package:flutter/material.dart';
import 'package:rg_track/const/enum/enum_form_options.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/ui/devices/single/device_form.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';

class UpdateDeviceScreen extends StatefulWidget {
  final Device device;

  const UpdateDeviceScreen({
    Key? key,
    required this.device,
  }) : super(key: key);

  @override
  State<UpdateDeviceScreen> createState() => _UpdateDeviceScreenState();
}

class _UpdateDeviceScreenState extends State<UpdateDeviceScreen> {
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
        title: 'ALTERAR EQUIPAMENTO',
        child: DeviceForm(
          device: widget.device,
          formOption: EnumFormOption.UPDATE,
        ),
      ),
    );
  }
}
