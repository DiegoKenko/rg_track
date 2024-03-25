import 'package:flutter/material.dart';
import 'package:rg_track/const/enum/enum_form_options.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/vehicles/single/vehicle_form.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';

class UpdateVehicleScreen extends StatefulWidget {
  final String? id;
  final Vehicle vehicle;

  const UpdateVehicleScreen({
    Key? key,
    this.id,
    required this.vehicle,
  }) : super(key: key);

  @override
  State<UpdateVehicleScreen> createState() => _UpdateVehicleScreenState();
}

class _UpdateVehicleScreenState extends State<UpdateVehicleScreen> {
  @override
  void initState() {
    super.initState();
  }

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
        title: "Dados do Veículo",
        child: VehicleForm(
          formOption: EnumFormOption.UPDATE,
          vehicle: widget.vehicle,
          enable: true,
        ),
      ),
    );
  }
}
