import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/model/permissions.dart';
import 'package:rg_track/service/auth/auth_service.dart';
import 'package:rg_track/ui/devices/conection/cubit/device_connection_cubit.dart';
import 'package:rg_track/ui/devices/conection/device_connection_params_alert_dialog.dart';
import 'package:rg_track/ui/devices/route.dart';
import 'package:rg_track/ui/devices/status/device_status_alert_dialog.dart';
import 'package:rg_track/ui/devices/list/cubit/devices_list_cubit.dart';
import 'package:rg_track/ui/devices/list/cubit/devices_list_state.dart';
import 'package:rg_track/ui/devices/list/devices_table_view.dart';
import 'package:rg_track/ui/devices/status/device_status_cubit.dart';
import 'package:rg_track/ui/devices/widget/device_card.dart';
import 'package:rg_track/ui/main/ui/widget/app_drawer.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';
import 'package:rg_track/ui/widget/delete_alert_dialog.dart';
import 'package:rg_track/ui/widget/message.dart';
import 'package:rg_track/ui/widget/show_loading.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/go_route_extension.dart';
import 'package:rg_track/utils/screen_utils.dart';

class IndexDevicesPage extends StatefulWidget {
  const IndexDevicesPage({super.key});

  @override
  State<IndexDevicesPage> createState() => _IndexDevicesPageState();
}

class _IndexDevicesPageState extends State<IndexDevicesPage> {
  late DevicesListCubit devicesListCubit;

  @override
  void initState() {
    devicesListCubit = context.read<DevicesListCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _createOne,
        child: Icon(MdiIcons.plus),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: SizedBox(
          height: 30,
          child: AppLogo.horizontal(),
        ),
      ),
      drawer: AppDrawer(
        onChange: (_, p) {},
        currentSelected: Permission.devices,
      ),
      body: AppBody(
        title: 'Equipamentos',
        child: Container(
          margin: EdgeInsets.only(
              top: context.onWideScreen(20, 20)!,
              right: context.onWideScreen(150, 16)!,
              left: context.onWideScreen(150, 16)!),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /*  Container(
                constraints: const BoxConstraints(maxWidth: 350),
                padding: const EdgeInsets.only(top: 10, bottom: 8),
                child: TextFormField(
                  controller: _searchCtrl,
                  focusNode: _searchFocus,
                  decoration: const InputDecoration(
                      hintText: 'Qual equipamento está buscando?'),
                  onChanged: (String value) {},
                ),
              ), */
              Expanded(
                child: BlocBuilder<DevicesListCubit, DevicesListState>(
                  bloc: devicesListCubit
                    ..loadDevices(AuthService.instance.user),
                  builder: (BuildContext context, DevicesListState state) {
                    if (state is DevicesListSuccessfulState) {
                      if (state.devices.isEmpty) {
                        return Message(
                          title: 'Nenhum equipamento por aqui ainda.',
                          body: 'Você pode cadastrar um agora.',
                          icon: MdiIcons.devices,
                          action: _createOne,
                          actionText: 'Novo equipamento',
                        );
                      }
                      if (isWideScreen(context)) {
                        return DevicesTableView(
                          state.devices,
                          onDeleteAction: _onDeleteAction,
                          onShowAction: _onShowAction,
                          onUpdateAction: _onUpdateAction,
                          onCheckConnection: _onCheckConnection,
                          onShowConnectionConfiguration:
                              _onShowConnectionConfiguration,
                        );
                      }
                      return ListView.builder(
                        itemCount: state.devices.length,
                        itemBuilder: (BuildContext context, int index) =>
                            DeviceCard(
                          state.devices[index],
                          onDeleteAction: _onDeleteAction,
                          onShowAction: _onShowAction,
                          onUpdateAction: _onUpdateAction,
                          onCheckConnection: _onCheckConnection,
                          onShowConnectionConfiguration:
                              _onShowConnectionConfiguration,
                        ),
                      );
                    }
                    return Center(
                      child: ShowLoading(
                        tryAgain: () async {},
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onShowAction(Device device) async {
    routeShowDevice.pushId(context, device.id, device);
  }

  Future<void> _onUpdateAction(Device device) async {
    await routeUpdateDevice.pushId(context, device.id, device);
    devicesListCubit
      .loadDevices(AuthService.instance.user);
  }

  Future<void> _onDeleteAction(Device device) async {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => const DeleteAlertDialog(),
    ).then((bool? value) async {
      if (value ?? false) {
        await devicesListCubit.delete(device).fold((success) {}, (e) {});
        devicesListCubit
          .loadDevices(AuthService.instance.user);
      }
    });
  }

  Future<void> _createOne() async {
    await routeStoreDevice.push(context);
    devicesListCubit
      .loadDevices(AuthService.instance.user);
  }

  Future<void> _onCheckConnection(Device device) async {
    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider<DeviceStatusCubit>(
          create: (BuildContext context) => DeviceStatusCubit(),
          child: DeviceStatusStatusAlertDialog(device: device),
        );
      },
    );
  }

  Future<void> _onShowConnectionConfiguration(Device device) async {
    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider<DeviceConnectionCubit>(
          create: (BuildContext context) => DeviceConnectionCubit(),
          child: DeviceConnectionParamsAlertDialog(device: device),
        );
      },
    );
  }
}
