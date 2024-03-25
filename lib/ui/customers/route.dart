import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/service/auth/auth_service.dart';
import 'package:rg_track/ui/customers/list/cubit/customer_list_cubit.dart';
import 'package:rg_track/ui/customers/list/index_customer_page.dart';
import 'package:rg_track/ui/customers/single/show_customer_screen.dart';
import 'package:rg_track/ui/customers/single/cubit/customer_single_cubit.dart';
import 'package:rg_track/ui/customers/single/store_customer_screen.dart';
import 'package:rg_track/ui/customers/single/update_customer_screen.dart';
import 'package:rg_track/utils/go_router_state_extension.dart';

final GoRoute routeShowCustomer = GoRoute(
  name: 'Visualizar Cliente',
  path: '/customers/show/:id',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      key: state.pageKey,
      providers: [
        BlocProvider<CustomerSingleCubit>(create: (_) => CustomerSingleCubit()),
      ],
      child: ShowCustomerScreen(
        id: state.id,
        customer: state.parseExtra<Customer>('customer')!,
      ),
    );
  },
);

final GoRoute routeStoreCustomer = GoRoute(
  name: 'Novo Cliente',
  path: '/customers/store',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      key: state.pageKey,
      providers: [
        BlocProvider<CustomerSingleCubit>(create: (_) => CustomerSingleCubit()),
      ],
      child: StoreCustomerScreen(
        customer: Customer(userParentId: AuthService.instance.user.id ?? ''),
      ),
    );
  },
);

final GoRoute routeUpdateCustomer = GoRoute(
  name: 'Atualizar Cliente',
  path: '/customers/update/:id',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      key: state.pageKey,
      providers: [
        BlocProvider<CustomerSingleCubit>(create: (_) => CustomerSingleCubit()),
      ],
      child: UpdateCustomerScreen(
        id: state.id,
        customer: state.parseExtra<Customer>('customer')!,
      ),
    );
  },
);
final GoRoute routeListCustomers = GoRoute(
  name: 'Clientes',
  path: '/customers',
  builder: (BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      key: state.pageKey,
      providers: [
        BlocProvider<CustomerListCubit>(create: (_) => CustomerListCubit()),
      ],
      child: const IndexCustomersPage(),
    );
  },
);
