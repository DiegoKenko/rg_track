import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rg_track/model/user.dart';
import 'package:rg_track/ui/users/child/list/cubit/users_child_list_cubit.dart';
import 'package:rg_track/ui/users/child/list/user_list_page.dart';
import 'package:rg_track/ui/users/child/single/cubit/users_child_single_cubit.dart';
import 'package:rg_track/ui/users/child/single/show_user_screen.dart';
import 'package:rg_track/ui/users/child/single/store_user_screen.dart';
import 'package:rg_track/ui/users/child/single/update_user_screen.dart';
import 'package:rg_track/utils/go_router_state_extension.dart';

final GoRoute routeShowUser = GoRoute(
  name: 'Visualizar Usuário',
  path: '/users/show/:id',
  builder: (BuildContext context, GoRouterState state) {
    return ShowUserScreen(
      id: state.parseExtra<UserEntity>('user')!.id ?? '',
      user: state.parseExtra<UserEntity>('user')!,
    );
  },
);

final GoRoute routeStoreUser = GoRoute(
  name: 'Novo Usuário',
  path: '/users/store',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserChildSingleCubit>(
          create: (BuildContext context) => UserChildSingleCubit(),
        ),
      ],
      child: const StoreUserScreen(),
    );
  },
);

final GoRoute routeUpdateUser = GoRoute(
  name: 'Atualizar Usuário',
  path: '/users/update/:id',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserChildSingleCubit>(
          create: (BuildContext context) => UserChildSingleCubit(),
        ),
      ],
      child: UpdateUserScreen(
        id: state.id,
        user: state.parseExtra<UserEntity>('user')!,
      ),
    );
  },
);

final GoRoute routeListUsers = GoRoute(
  name: 'Usuários',
  path: '/users',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserChildListCubit>(
          create: (BuildContext context) => UserChildListCubit(),
        ),
      ],
      child: const UserListPage(),
    );
  },
);
