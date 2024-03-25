import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/vehicle_event.dart';
import 'package:rg_track/ui/events/cubit/vehicle_events_cubit.dart';
import 'package:rg_track/ui/events/cubit/vehicle_events_state.dart';
import 'package:rg_track/ui/events/route.dart';
import 'package:rg_track/ui/events/widget/vehicle_event_card.dart';
import 'package:rg_track/ui/events/widget/vehicle_event_table_view.dart';
import 'package:rg_track/ui/widget/delete_alert_dialog.dart';
import 'package:rg_track/ui/widget/message.dart';
import 'package:rg_track/ui/widget/show_loading.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/go_route_extension.dart';
import 'package:rg_track/utils/screen_utils.dart';

class IndexVehicleEventsPage extends StatefulWidget {
  const IndexVehicleEventsPage({Key? key}) : super(key: key);

  @override
  State<IndexVehicleEventsPage> createState() => _IndexVehicleEventsPageState();
}

class _IndexVehicleEventsPageState extends State<IndexVehicleEventsPage> {
  @override
  void initState() {
    context.read<VehicleEventsCubit>().refreshVehicleEvents(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _createVehicleEvent,
        child: Icon(MdiIcons.plus),
      ),
      body: Container(
        margin: EdgeInsets.only(
            right: context.onWideScreen(150, 16)!,
            left: context.onWideScreen(150, 16)!),
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                Container(
                  constraints: const BoxConstraints(maxWidth: 350),
                  padding: const EdgeInsets.only(top: 10, bottom: 8),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Qual evento está buscando?'),
                  ),
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<VehicleEventsCubit, VehicleEventsState>(
                  buildWhen: (VehicleEventsState previous,
                          VehicleEventsState current) =>
                      current is ListVehicleEventState,
                  builder: (BuildContext context, VehicleEventsState state) {
                    if (state is ListVehicleEventState) {
                      if (state.vehicleEvents.isEmpty) {
                        return Message(
                          title: 'Nenhum evento por aqui ainda.',
                          body: 'Você pode cadastrar um agora.',
                          icon: MdiIcons.formatListBulleted,
                          action: _createVehicleEvent,
                          actionText: 'Novo evento',
                        );
                      }
                      if (isWideScreen(context)) {
                        return VehicleEventsTableView(
                          state.vehicleEvents,
                          onDeleteAction: onDeleteAction,
                          onShowAction: onShowAction,
                          onUpdateAction: onUpdateAction,
                        );
                      }
                      return ListView.builder(
                        itemCount: state.vehicleEvents.length,
                        itemBuilder: (BuildContext context, int index) =>
                            VehicleEventCard(
                          state.vehicleEvents[index],
                          onDeleteAction: onDeleteAction,
                          onShowAction: onShowAction,
                          onUpdateAction: onUpdateAction,
                        ),
                      );
                    }
                    return Center(
                        child: ShowLoading(
                      tryAgain: () => context
                          .read<VehicleEventsCubit>()
                          .refreshVehicleEvents(),
                    ));
                  }),
            )
          ],
        ),
      ),
    );
  }

  void onShowAction(VehicleEvent vehicleEvent) {
    routeShowVehicleEvent.pushId(
        context, vehicleEvent.id.toString(), vehicleEvent);
  }

  void onUpdateAction(VehicleEvent vehicleEvent) {
    routeUpdateVehicleEvent.pushId(
        context, vehicleEvent.id.toString(), vehicleEvent);
  }

  void onDeleteAction(VehicleEvent vehicleEvent) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => const DeleteAlertDialog(),
    ).then((bool? value) async {
      if (value ?? false) {
        await context
            .read<VehicleEventsCubit>()
            .deleteVehicleEvent(vehicleEvent);
        context.read<VehicleEventsCubit>().refreshVehicleEvents(true);
      }
    });
  }

  void _createVehicleEvent() {
    routeStoreVehicleEvent.go(context);
  }
}
