import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/reports/vehicle_location_history/cubit/location_history_cubit.dart';
import 'package:rg_track/ui/reports/vehicle_location_history/cubit/location_vehicle_cubit.dart';
import 'package:rg_track/ui/reports/vehicle_location_history/vehicle_location_history_screen.dart';
import 'package:rg_track/utils/go_router_state_extension.dart';

final GoRoute routeVehicleLocationHistoryScreen = GoRoute(
  name: 'Histórico de Localização do Veículo',
  path: '/historico',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LocationHistoryCubit>(
            create: (BuildContext context) =>
                context.read<LocationHistoryCubit>(),
          ),
          BlocProvider<LocationVehicleListCubit>(
            create: (BuildContext context) =>
                context.read<LocationVehicleListCubit>(),
          ),
        ],
        child: VehicleLocationHistoryScreen(
          id: state.id ?? '',
          vehicle: state.parseExtra<Vehicle>('vehicle', null),
        ));
  },
);
