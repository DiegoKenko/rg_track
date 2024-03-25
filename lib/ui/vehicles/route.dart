import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/devices/list/cubit/devices_list_cubit.dart';
import 'package:rg_track/ui/vehicles/list/cubit/vehicles_list_cubit.dart';
import 'package:rg_track/ui/vehicles/list/index_vehicle_page.dart';
import 'package:rg_track/ui/vehicles/single/cubit/vehicle_single_cubit.dart';
import 'package:rg_track/ui/vehicles/single/show_vehicle_screen.dart';
import 'package:rg_track/ui/vehicles/single/store_vehicle_screen.dart';
import 'package:rg_track/ui/vehicles/single/update_vehicle_screen.dart';
import 'package:rg_track/utils/go_router_state_extension.dart';

final GoRoute routeShowVehicle = GoRoute(
  name: 'Visualizar Veículo',
  path: '/vehicles/show/:id',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      key: state.pageKey,
      providers: [
        BlocProvider<VehicleSingleCubit>(
            create: (BuildContext context) => VehicleSingleCubit()),
      ],
      child: ShowVehicleScreen(
        id: state.id,
        vehicle: state.parseExtra<Vehicle>('vehicle') ?? Vehicle(userId: ''),
      ),
    );
  },
);

final GoRoute routeStoreVehicle = GoRoute(
  name: 'Novo Veículo',
  path: '/vehicles/store',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      key: state.pageKey,
      providers: [
        BlocProvider<VehicleSingleCubit>(
            create: (BuildContext context) => VehicleSingleCubit()),
        BlocProvider<DevicesListCubit>(
            create: (BuildContext context) => DevicesListCubit()),
      ],
      child: const CreateVehicleScreen(),
    );
  },
);

final GoRoute routeUpdateVehicle = GoRoute(
  name: 'Atualizar Veículo',
  path: '/vehicles/update/:id',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      key: state.pageKey,
      providers: [
        BlocProvider<VehicleSingleCubit>(
            create: (BuildContext context) => VehicleSingleCubit()),
        BlocProvider<DevicesListCubit>(
            create: (BuildContext context) => DevicesListCubit()),
      ],
      child: UpdateVehicleScreen(
        id: state.id,
        vehicle: state.parseExtra<Vehicle>('vehicle') ?? Vehicle(userId: ''),
      ),
    );
  },
);

final GoRoute routeListVehicle = GoRoute(
  name: 'Veículos',
  path: '/vehicles',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      key: state.pageKey,
      providers: [
        BlocProvider<VehicleListCubit>(
            create: (BuildContext context) => VehicleListCubit()),
      ],
      child: const IndexVehiclesPage(),
    );
  },
);
