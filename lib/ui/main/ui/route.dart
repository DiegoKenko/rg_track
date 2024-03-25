import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rg_track/ui/main/ui/main_screen.dart';

final GoRoute routeShowMain = GoRoute(
  name: 'Home',
  path: '/',
  builder: (BuildContext context, GoRouterState state) {
    return const MainScreen();
  },
);
