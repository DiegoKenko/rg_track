import 'package:flutter/material.dart';
import 'package:rg_track/const/enum/enum_form_options.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/service/auth/auth_service.dart';
import 'package:rg_track/ui/vehicles/single/vehicle_form.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';

class CreateVehicleScreen extends StatefulWidget {
  const CreateVehicleScreen({super.key});

  @override
  State<CreateVehicleScreen> createState() => _CreateVehicleScreenState();
}

class _CreateVehicleScreenState extends State<CreateVehicleScreen> {
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
        title: 'NOVO VEÍCULO',
        child: VehicleForm(
          formOption: EnumFormOption.CREATE,
          vehicle: Vehicle(userId: AuthService.instance.user.id ?? ''),
        ),
      ),
    );
  }
}
