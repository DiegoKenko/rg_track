import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:rg_track/ui/auth/route.dart';
import 'package:rg_track/ui/customers/route.dart';
import 'package:rg_track/ui/dashboard/route.dart';
import 'package:rg_track/ui/devices/route.dart';
import 'package:rg_track/ui/drivers/route.dart';
import 'package:rg_track/ui/events/route.dart';
import 'package:rg_track/ui/main/ui/route.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/route.dart';
import 'package:rg_track/ui/plans/route.dart';
import 'package:rg_track/ui/reports/moving_stop/route.dart';
import 'package:rg_track/ui/reports/vehicle_location_history/route.dart';
import 'package:rg_track/ui/splash_screen.dart';
import 'package:rg_track/ui/users/route.dart';
import 'package:rg_track/ui/vehicles/route.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: '/boas-vindas',
  routes: [
    routeForgotPassword,
    routeShowCustomer,
    routeShowDevice,
    routeShowDriver,
    routeShowMain,
    routeShowPlan,
    routeShowUser,
    routeShowVehicle,
    routeShowVehicleEvent,
    routeSignIn,
    routeStoreCustomer,
    routeStoreDevice,
    routeStoreDriver,
    routeStorePlan,
    routeStoreUser,
    routeStoreVehicle,
    routeStoreVehicleEvent,
    routeUpdateCustomer,
    routeUpdateDevice,
    routeUpdateDriver,
    routeUpdatePlan,
    routeUpdateUser,
    routeUpdateVehicle,
    routeUpdateVehicleEvent,
    routeVehicleLocationHistoryScreen,
    routeAnalyticReport,
    routeListVehicle,
    routeListDevices,
    routeListUsers,
    routeListCustomers,
    routeDashboard,
    routeMovingStopMap,
    GoRoute(
      name: 'Boas Vindas',
      path: '/boas-vindas',
      builder: (BuildContext context, GoRouterState state) =>
          const SplashScreen(),
    ),
  ],
);
