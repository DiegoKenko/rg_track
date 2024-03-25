import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/model/vehicle_event.dart';
import 'package:rg_track/ui/events/cubit/vehicle_events_cubit.dart';
import 'package:rg_track/ui/events/cubit/vehicle_events_state.dart';
import 'package:rg_track/ui/events/vehicle_event_form.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';
import 'package:rg_track/ui/widget/show_error.dart';
import 'package:rg_track/ui/widget/show_loading.dart';
import 'package:rg_track/utils/context_extension.dart';

class UpdateVehicleEventScreen extends StatefulWidget {
  final String? id;
  final VehicleEvent? vehicleEvent;

  const UpdateVehicleEventScreen({
    super.key,
    this.id,
    this.vehicleEvent,
  });

  @override
  State<UpdateVehicleEventScreen> createState() =>
      _UpdateVehicleEventScreenState();
}

class _UpdateVehicleEventScreenState extends State<UpdateVehicleEventScreen> {
  @override
  void initState() {
    if (widget.vehicleEvent == null && widget.id != null) {
      context.read<VehicleEventsCubit>().showVehicleEvent(widget.id!);
    }
    super.initState();
  }

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
      body: BlocBuilder<VehicleEventsCubit, VehicleEventsState>(
        builder: (BuildContext context, VehicleEventsState state) {
          if (widget.vehicleEvent != null) {
            return AppBody(
              title: "Dados do Evento",
              child: VehicleEventForm(
                vehicleEvent: widget.vehicleEvent,
                enable: true,
              ),
            );
          }
          if (state is VehicleEventLoadByIdState) {
            return AppBody(
              title: "Dados do Evento",
              child: VehicleEventForm(
                vehicleEvent: state.vehicleEvent,
                enable: true,
              ),
            );
          }
          if (state is VehicleEventShowFailsState) {
            return ShowError(state.exception);
          }
          return Center(
            child: ShowLoading(tryAgain: () async {
              if (widget.vehicleEvent == null && widget.id != null) {
                await context
                    .read<VehicleEventsCubit>()
                    .showVehicleEvent(widget.id!);
              }
            }),
          );
        },
      ),
    );
  }
}
