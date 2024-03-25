import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/ui/devices/list/cubit/devices_list_cubit.dart';
import 'package:rg_track/ui/devices/list/index_devices_page.dart';
import 'package:rg_track/ui/devices/single/cubit/device_single_cubit.dart';
import 'package:rg_track/ui/devices/single/show_device_screen.dart';
import 'package:rg_track/ui/devices/single/store_device_screen.dart';
import 'package:rg_track/ui/devices/single/update_device_screen.dart';
import 'package:rg_track/utils/go_router_state_extension.dart';

final GoRoute routeShowDevice = GoRoute(
  name: 'Visualizar Dispositivo',
  path: '/devices/show/:id',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      key: state.pageKey,
      providers: [
        BlocProvider<DeviceSingleCubit>(
            create: (BuildContext context) => DeviceSingleCubit()),
      ],
      child: ShowDeviceScreen(
        device: state.parseExtra<Device>('device') ?? Device(),
      ),
    );
  },
);

final GoRoute routeStoreDevice = GoRoute(
  name: 'Novo Dispositivo',
  path: '/devices/store',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      key: state.pageKey,
      providers: [
        BlocProvider<DeviceSingleCubit>(
            create: (BuildContext context) => DeviceSingleCubit()),
      ],
      child: const StoreDeviceScreen(),
    );
  },
);

final GoRoute routeUpdateDevice = GoRoute(
  name: 'Atualizar Dispositivo',
  path: '/devices/update/:id',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      key: state.pageKey,
      providers: [
        BlocProvider<DeviceSingleCubit>(
            create: (BuildContext context) => DeviceSingleCubit()),
      ],
      child: UpdateDeviceScreen(
        device: state.parseExtra<Device>('device') ?? Device(),
      ),
    );
  },
);
final GoRoute routeListDevices = GoRoute(
  name: 'Dispositivos',
  path: '/devices',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      key: state.pageKey,
      providers: [
        BlocProvider<DevicesListCubit>(
            create: (BuildContext context) => DevicesListCubit()),
      ],
      child: const IndexDevicesPage(),
    );
  },
);
