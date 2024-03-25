import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_controller_cubit.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_moving_stop_cubit.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/moving_stop_map_page_mobile.dart';
import 'package:rg_track/ui/reports/moving_stop/cubit/moving_stop_cubit.dart';
import 'package:rg_track/utils/go_router_state_extension.dart';

final GoRoute routeMovingStopMap = GoRoute(
  name: 'Mapa',
  path: '/relatorio/map/:id',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      key: state.pageKey,
      providers: [
        BlocProvider<MovingStopCubit>(
            create: (BuildContext context) => MovingStopCubit()),
        BlocProvider<MapMovingStopCubit>(
            create: (BuildContext context) => MapMovingStopCubit()),
        BlocProvider<MapControllerCubit>(
            create: (BuildContext context) => MapControllerCubit()),
      ],
      child: MovingStopMapPageMobile(
        vehicle: state.parseExtra<Vehicle>('vehicle')!,
      ),
    );
  },
);
