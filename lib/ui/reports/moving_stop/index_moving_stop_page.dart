import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/const/theme.dart';
import 'package:rg_track/model/permissions.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/main/ui/widget/app_drawer.dart';
import 'package:rg_track/ui/reports/moving_stop/cubit/moving_stop_cubit.dart';
import 'package:rg_track/ui/reports/moving_stop/cubit/moving_stop_state.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/mobile_moving_stop.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/wide_moving_stop.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';
import 'package:rg_track/utils/screen_utils.dart';

class IndexMovingStopPage extends StatefulWidget {
  const IndexMovingStopPage({super.key});

  @override
  State<IndexMovingStopPage> createState() => IndexMovingStopPageState();
}

class IndexMovingStopPageState extends State<IndexMovingStopPage> {
  final DateTime _lastUpdate = DateTime.now();
  List<Vehicle> vehicles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: SizedBox(
          height: 30,
          child: AppLogo.horizontal(),
        ),
      ),
      drawer: AppDrawer(
        onChange: (a, b) {},
        currentSelected: Permission.reportMovingAndStop,
      ),
      body: AppBody(
        title: 'Relatório de deslocamentos',
        child: BlocBuilder<MovingStopCubit, MovingStopState>(
            bloc: context.read<MovingStopCubit>()..init(),
            builder: (context, state) {
              if (state is MovingStopSuccessState) {
                vehicles = state.vehicles;
              }
              if (state is MovingStopLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    color: primaryColor,
                  ),
                );
              }
              return isWideScreen(context)
                  ? WideMovingStop(
                      lastUpdate: _lastUpdate,
                      vehicles: vehicles,
                    )
                  : MobileMovingStop(
                      lastUpdate: _lastUpdate,
                      vehicles: vehicles,
                    );
            }),
      ),
    );
  }
}
