import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/model/driver.dart';
import 'package:rg_track/ui/drivers/cubit/drivers_cubit.dart';
import 'package:rg_track/ui/drivers/cubit/drivers_state.dart';
import 'package:rg_track/ui/drivers/driver_form.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';
import 'package:rg_track/ui/widget/show_error.dart';
import 'package:rg_track/ui/widget/show_loading.dart';
import 'package:rg_track/utils/context_extension.dart';

class UpdateDriverScreen extends StatefulWidget {
  final String? id;
  final Driver? driver;

  const UpdateDriverScreen({
    Key? key,
    this.id,
    this.driver,
  }) : super(key: key);

  @override
  State<UpdateDriverScreen> createState() => _UpdateDriverScreenState();
}

class _UpdateDriverScreenState extends State<UpdateDriverScreen> {
  @override
  void initState() {
    if (widget.driver == null && widget.id != null) {
      context.read<DriversCubit>().showDriver(widget.id!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.onWideScreen(150, 75),
        title: SizedBox(
          height: 40,
          child: AppLogo.horizontal(),
        ),
      ),
      body: BlocBuilder<DriversCubit, DriversState>(
        builder: (BuildContext context, DriversState state) {
          if (widget.driver != null) {
            return AppBody(
              title: "Dados do Motorista",
              child: DriverForm(
                driver: widget.driver,
                enable: false,
              ),
            );
          }
          if (state is DriverLoadByIdState) {
            return AppBody(
              title: "Dados do Motorista",
              child: DriverForm(
                driver: state.driver,
                enable: false,
              ),
            );
          }
          if (state is DriverShowFailsState) {
            return ShowError(state.exception);
          }
          return Center(
            child: ShowLoading(tryAgain: () async {
              if (widget.driver == null && widget.id != null) {
                await context.read<DriversCubit>().showDriver(widget.id!);
              }
            }),
          );
        },
      ),
    );
  }
}
