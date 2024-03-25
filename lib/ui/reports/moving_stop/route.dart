import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_controller_cubit.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_moving_stop_cubit.dart';
import 'package:rg_track/ui/reports/moving_stop/cubit/moving_stop_cubit.dart';
import 'package:rg_track/ui/reports/moving_stop/index_moving_stop_page.dart';

final GoRoute routeAnalyticReport = GoRoute(
  name: 'Relatório de deslocamentos',
  path: '/relatorio_deslocamento',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
        key: state.pageKey,
        providers: [
          BlocProvider<MovingStopCubit>(
            create: (BuildContext context) => MovingStopCubit(),
          ),
          BlocProvider<MapMovingStopCubit>(
              create: (BuildContext context) => MapMovingStopCubit()),
          BlocProvider<MapControllerCubit>(
              create: (BuildContext context) => MapControllerCubit()),
        ],
        child: const IndexMovingStopPage());
  },
);
