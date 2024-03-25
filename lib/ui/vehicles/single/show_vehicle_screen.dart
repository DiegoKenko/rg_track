import 'package:flutter/material.dart';
import 'package:rg_track/const/enum/enum_form_options.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/vehicles/single/vehicle_form.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';

class ShowVehicleScreen extends StatefulWidget {
  final String? id;
  final Vehicle vehicle;

  const ShowVehicleScreen({
    Key? key,
    required this.vehicle,
    this.id,
  }) : super(key: key);

  @override
  State<ShowVehicleScreen> createState() => _ShowVehicleScreenState();
}

class _ShowVehicleScreenState extends State<ShowVehicleScreen> {
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
          vehicle: widget.vehicle,
          formOption: EnumFormOption.UPDATE,
          enable: false,
        ),
      ),
    );
  }
}
