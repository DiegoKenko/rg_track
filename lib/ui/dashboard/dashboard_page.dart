import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/model/permissions.dart';
import 'package:rg_track/ui/dashboard/cubit/dashboard_cubit.dart';
import 'package:rg_track/ui/dashboard/cubit/dashboard_state.dart';
import 'package:rg_track/ui/dashboard/widget/mobile_dashboard.dart';
import 'package:rg_track/ui/dashboard/widget/wide_dashboard.dart';
import 'package:rg_track/ui/main/ui/widget/app_drawer.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';
import 'package:rg_track/utils/screen_utils.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
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
        currentSelected: Permission.dashboard,
      ),
      body: AppBody(
        title: 'Dashboard',
        child: BlocBuilder<DashboardCubit, DashboardState>(
          bloc: DashboardCubit()..init(),
          builder: (context, state) {
            if (state is DashboardSuccessState) {
              if (state.events.isEmpty) {
                return const Center(
                  child: Text('Nenhum evento encontrado'),
                );
              }
              return isWideScreen(context)
                  ? WideDashboard(
                      events: state.events,
                      countGreenStatus: state.countGreenStatus,
                      countYellowStatus: state.countYellowStatus,
                      countRedStatus: state.countRedStatus,
                    )
                  : MobileDashboard(
                      event: state.events,
                      countGreenStatus: state.countGreenStatus,
                      countYellowStatus: state.countYellowStatus,
                      countRedStatus: state.countRedStatus,
                    );
            }
            if (state is DashboardLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(child: Container());
          },
        ),
      ),
    );
  }
}
