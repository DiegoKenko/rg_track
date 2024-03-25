import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rg_track/ui/dashboard/cubit/dashboard_cubit.dart';
import 'package:rg_track/ui/dashboard/dashboard_page.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_controller_cubit.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_moving_stop_cubit.dart';

final GoRoute routeDashboard = GoRoute(
  name: 'Dashboard',
  path: '/dashboard',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      key: state.pageKey,
      providers: [
        BlocProvider<DashboardCubit>(
            create: (BuildContext context) => DashboardCubit()),
        BlocProvider<MapMovingStopCubit>(
            create: (BuildContext context) => MapMovingStopCubit()),
        BlocProvider<MapControllerCubit>(
            create: (BuildContext context) => MapControllerCubit()),
      ],
      child: const DashboardPage(),
    );
  },
);

final GoRoute routeDashBoardsMap = GoRoute(
  name: 'Dashboard',
  path: '/dashboard/map/:id',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
        key: state.pageKey,
        providers: [
          BlocProvider<DashboardCubit>(
              create: (BuildContext context) => DashboardCubit()),
          BlocProvider<MapControllerCubit>(
              create: (BuildContext context) => MapControllerCubit()),
        ],
        child: Container());
  },
);
