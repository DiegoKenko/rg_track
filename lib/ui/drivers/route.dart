import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rg_track/model/driver.dart';
import 'package:rg_track/ui/drivers/cubit/drivers_cubit.dart';
import 'package:rg_track/ui/drivers/show_driver_screen.dart';
import 'package:rg_track/ui/drivers/store_driver_screen.dart';
import 'package:rg_track/ui/drivers/update_driver_screen.dart';
import 'package:rg_track/ui/widget/vehicles_form/vehicles_form_cubit.dart';
import 'package:rg_track/utils/go_router_state_extension.dart';

final GoRoute routeShowDriver = GoRoute(
  name: 'Visualizar Motorista',
  path: '/drivers/show/:id',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      key: state.pageKey,
      providers: [
        BlocProvider<DriversCubit>(create: (_) => context.read<DriversCubit>()),
        BlocProvider<VehiclesFormCubit>(
            create: (_) => context.read<VehiclesFormCubit>()),
      ],
      child: ShowDriverScreen(
        id: state.id,
        driver: state.parseExtra<Driver>('driver'),
      ),
    );
  },
);

final GoRoute routeStoreDriver = GoRoute(
  name: 'Novo Motorista',
  path: '/drivers/store',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      key: state.pageKey,
      providers: [
        BlocProvider<DriversCubit>(create: (_) => context.read<DriversCubit>()),
        BlocProvider<VehiclesFormCubit>(
            create: (_) => context.read<VehiclesFormCubit>()),
      ],
      child: const StoreDriverScreen(),
    );
  },
);

final GoRoute routeUpdateDriver = GoRoute(
  name: 'Atualizar Motorista',
  path: '/drivers/update/:id',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      key: state.pageKey,
      providers: [
        BlocProvider<DriversCubit>(create: (_) => context.read<DriversCubit>()),
        BlocProvider<VehiclesFormCubit>(
            create: (_) => context.read<VehiclesFormCubit>()),
      ],
      child: UpdateDriverScreen(
        id: state.id,
        driver: state.parseExtra<Driver>('driver'),
      ),
    );
  },
);
