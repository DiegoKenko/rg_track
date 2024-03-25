import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rg_track/model/vehicle_event.dart';
import 'package:rg_track/ui/events/cubit/vehicle_events_cubit.dart';
import 'package:rg_track/ui/events/show_vehicle_event_screen.dart';
import 'package:rg_track/ui/events/store_vehicle_event_screen.dart';
import 'package:rg_track/ui/events/update_vehicle_event_screen.dart';
import 'package:rg_track/utils/go_router_state_extension.dart';

final GoRoute routeShowVehicleEvent = GoRoute(
  name: 'Visualizar Evento do Veículo',
  path: '/events/show/:id',
  builder: (BuildContext context, GoRouterState state) {
    return BlocProvider<VehicleEventsCubit>(
      key: state.pageKey,
      create: (BuildContext context) => context.read<VehicleEventsCubit>(),
      child: ShowVehicleEventScreen(
        id: state.id,
        vehicleEvent: state.parseExtra<VehicleEvent>('vehicleEvent'),
      ),
    );
  },
);

final GoRoute routeStoreVehicleEvent = GoRoute(
  name: 'Novo Evento do Veículo',
  path: '/events/store',
  builder: (BuildContext context, GoRouterState state) {
    return BlocProvider<VehicleEventsCubit>(
      key: state.pageKey,
      create: (BuildContext context) => context.read<VehicleEventsCubit>(),
      child: const StoreVehicleEventScreen(),
    );
  },
);

final GoRoute routeUpdateVehicleEvent = GoRoute(
  name: 'Atualizar Evento do Veículo',
  path: '/events/update/:id',
  builder: (BuildContext context, GoRouterState state) {
    return BlocProvider<VehicleEventsCubit>(
      key: state.pageKey,
      create: (BuildContext context) => context.read<VehicleEventsCubit>(),
      child: UpdateVehicleEventScreen(
        id: state.id,
        vehicleEvent: state.parseExtra<VehicleEvent>('vehicleEvent'),
      ),
    );
  },
);
