import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/service/auth/auth_service.dart';
import 'package:rg_track/model/permissions.dart';
import 'package:rg_track/ui/main/ui/widget/app_drawer.dart';
import 'package:rg_track/ui/vehicles/list/cubit/vehicles_list_cubit.dart';
import 'package:rg_track/ui/vehicles/list/cubit/vehicles_list_state.dart';
import 'package:rg_track/ui/vehicles/list/vehicle_card.dart';
import 'package:rg_track/ui/vehicles/list/vehicle_table_view.dart';
import 'package:rg_track/ui/vehicles/route.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';
import 'package:rg_track/ui/widget/delete_alert_dialog.dart';
import 'package:rg_track/ui/widget/message.dart';
import 'package:rg_track/ui/widget/show_loading.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/go_route_extension.dart';
import 'package:rg_track/utils/screen_utils.dart';

class IndexVehiclesPage extends StatefulWidget {
  const IndexVehiclesPage({super.key});

  @override
  State<IndexVehiclesPage> createState() => _IndexVehiclesPageState();
}

class _IndexVehiclesPageState extends State<IndexVehiclesPage> {
  final AuthService authService = AuthService.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        onChange: (_, p) {},
        currentSelected: Permission.vehicles,
      ),
      appBar: AppBar(
        title: SizedBox(
          height: 30,
          child: AppLogo.horizontal(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createVehicle,
        child: Icon(MdiIcons.plus),
      ),
      body: AppBody(
        title: 'Veículos',
        child: Container(
          margin: EdgeInsets.only(
              top: context.onWideScreen(20, 20)!,
              right: context.onWideScreen(150, 16)!,
              left: context.onWideScreen(150, 16)!),
          child: Column(
            children: [
              /*    Row(
                children: [
                  const Spacer(),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 350),
                    padding: const EdgeInsets.only(top: 10, bottom: 8),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Qual veículo está buscando?'),
                    ),
                  ),
                ],
              ), */
              Expanded(
                child: BlocBuilder<VehicleListCubit, VehiclesListState>(
                  bloc: context.read<VehicleListCubit>()
                    ..loadVehicles(AuthService.instance.user.id ?? ''),
                  builder: (BuildContext context, VehiclesListState state) {
                    if (state is VehicleListSuccessfulState) {
                      if (state.vehicles.isEmpty) {
                        return Message(
                          title: 'Nenhum veículo por aqui ainda.',
                          body: 'Você pode cadastrar um agora.',
                          icon: MdiIcons.car,
                          action: _createVehicle,
                          actionText: 'Novo veículo',
                        );
                      }
                      if (isWideScreen(context)) {
                        return VehiclesTableView(
                          state.vehicles,
                          onDeleteAction: onDeleteAction,
                          onShowAction: onShowAction,
                          onUpdateAction: onUpdateAction,
                        );
                      }
                      return ListView.builder(
                        itemCount: state.vehicles.length,
                        itemBuilder: (BuildContext context, int index) =>
                            VehicleCard(
                          state.vehicles[index],
                          onDeleteAction: onDeleteAction,
                          onShowAction: onShowAction,
                          onUpdateAction: onUpdateAction,
                        ),
                      );
                    }
                    return Center(
                        child: ShowLoading(
                      tryAgain: () => context
                          .read<VehicleListCubit>()
                          .refreshVehicles(AuthService.instance.user.id ?? ''),
                    ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onShowAction(Vehicle vehicle) async {
    routeShowVehicle.pushId(context, vehicle.id, vehicle);
  }

  Future<void> onUpdateAction(Vehicle vehicle) async {
    routeUpdateVehicle.pushId(context, vehicle.id, vehicle).then((value) {
      context.read<VehicleListCubit>()
        .refreshVehicles(AuthService.instance.user.id ?? '');
    });
  }

  Future<void> onDeleteAction(Vehicle vehicle) async {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => const DeleteAlertDialog(),
    ).then((bool? value) async {
      if (value ?? false) {
        context.read<VehicleListCubit>().deleteVehicle(vehicle);
        context
            .read<VehicleListCubit>()
            .refreshVehicles(AuthService.instance.user.id ?? '');
      }
    });
  }

  Future<void> _createVehicle() async {
    await routeStoreVehicle.push(context).then((value) => {
          context.read<VehicleListCubit>()
            ..refreshVehicles(AuthService.instance.user.id ?? '')
        });
  }
}
