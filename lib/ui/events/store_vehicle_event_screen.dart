import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/model/vehicle_event.dart';
import 'package:rg_track/ui/events/cubit/vehicle_events_cubit.dart';
import 'package:rg_track/ui/events/vehicle_event_form.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';
import 'package:rg_track/utils/context_extension.dart';

class StoreVehicleEventScreen extends StatelessWidget {
  const StoreVehicleEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.onWideScreen(150, 75),
        title: SizedBox(
          height: 40,
          child: AppLogo.horizontal(),
        ),
      ),
      body: AppBody(
        title: 'Novo Evento',
        child: VehicleEventForm(onSave: (VehicleEvent driver) {
          context.read<VehicleEventsCubit>().storeVehicleEvent(driver);
        }),
      ),
    );
  }
}
