import 'package:flutter/material.dart';
import 'package:rg_track/const/enum/enum_form_options.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/service/auth/auth_service.dart';
import 'package:rg_track/ui/devices/single/device_form.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';

class StoreDeviceScreen extends StatefulWidget {
  const StoreDeviceScreen({super.key});

  @override
  State<StoreDeviceScreen> createState() => _StoreDeviceScreenState();
}

class _StoreDeviceScreenState extends State<StoreDeviceScreen> {
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
        title: 'NOVO EQUIPAMENTO',
        child: DeviceForm(
          device: Device(userId: AuthService.instance.user.id ?? ''),
          formOption: EnumFormOption.CREATE,
        ),
      ),
    );
  }
}
