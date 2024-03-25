import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rg_track/model/plan.dart';
import 'package:rg_track/ui/plans/cubit/plans_cubit.dart';
import 'package:rg_track/ui/plans/show_plan_screen.dart';
import 'package:rg_track/ui/plans/store_plan_screen.dart';
import 'package:rg_track/ui/plans/update_plan_screen.dart';
import 'package:rg_track/ui/widget/vehicles_form/permissions_cubit.dart';
import 'package:rg_track/utils/go_router_state_extension.dart';

final GoRoute routeShowPlan = GoRoute(
  name: 'Visualizar Plano',
  path: '/plans/show/:id',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlansCubit>(
          create: (_) => context.read<PlansCubit>(),
        ),
        BlocProvider<PermissionsCubit>(
          create: (_) => context.read<PermissionsCubit>(),
        ),
      ],
      key: state.pageKey,
      child: ShowPlanScreen(
        id: state.id,
        plan: state.parseExtra<Plan>('plan'),
      ),
    );
  },
);

final GoRoute routeStorePlan = GoRoute(
  name: 'Novo Plano',
  path: '/plans/store',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlansCubit>(
          create: (_) => context.read<PlansCubit>(),
        ),
        BlocProvider<PermissionsCubit>(
          create: (_) => context.read<PermissionsCubit>(),
        ),
      ],
      key: state.pageKey,
      child: const StorePlanScreen(),
    );
  },
);

final GoRoute routeUpdatePlan = GoRoute(
  name: 'Atualizar Plano',
  path: '/plans/update/:id',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlansCubit>(
          create: (_) => context.read<PlansCubit>(),
        ),
        BlocProvider<PermissionsCubit>(
          create: (_) => context.read<PermissionsCubit>(),
        ),
      ],
      key: state.pageKey,
      child: UpdatePlanScreen(
        id: state.id,
        plan: state.parseExtra<Plan>('plan'),
      ),
    );
  },
);
