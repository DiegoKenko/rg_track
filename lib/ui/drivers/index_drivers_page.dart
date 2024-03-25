import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/driver.dart';
import 'package:rg_track/ui/drivers/cubit/drivers_cubit.dart';
import 'package:rg_track/ui/drivers/cubit/drivers_state.dart';
import 'package:rg_track/ui/drivers/route.dart';
import 'package:rg_track/ui/drivers/widget/driver_card.dart';
import 'package:rg_track/ui/drivers/widget/drivers_table_view.dart';
import 'package:rg_track/ui/widget/delete_alert_dialog.dart';
import 'package:rg_track/ui/widget/message.dart';
import 'package:rg_track/ui/widget/show_loading.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/go_route_extension.dart';
import 'package:rg_track/utils/screen_utils.dart';

class IndexDriversPage extends StatefulWidget {
  const IndexDriversPage({Key? key}) : super(key: key);

  @override
  State<IndexDriversPage> createState() => _IndexDriversPageState();
}

class _IndexDriversPageState extends State<IndexDriversPage> {
  @override
  void initState() {
    context.read<DriversCubit>().refreshDrivers(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _createDriver,
        child: Icon(MdiIcons.plus),
      ),
      body: Container(
        margin: EdgeInsets.only(
            right: context.onWideScreen(150, 16)!,
            left: context.onWideScreen(150, 16)!),
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                Container(
                  constraints: const BoxConstraints(maxWidth: 350),
                  padding: const EdgeInsets.only(top: 10, bottom: 8),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Qual motorista está buscando?'),
                  ),
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<DriversCubit, DriversState>(
                  buildWhen: (DriversState previous, DriversState current) =>
                      current is ListDriverState,
                  builder: (BuildContext context, DriversState state) {
                    if (state is ListDriverState) {
                      if (state.drivers.isEmpty) {
                        return Message(
                          title: 'Nenhum motorista por aqui ainda.',
                          body: 'Você pode cadastrar um agora.',
                          icon: MdiIcons.cardAccountDetailsOutline,
                          action: _createDriver,
                          actionText: 'Novo motorista',
                        );
                      }
                      if (isWideScreen(context)) {
                        return DriversTableView(
                          state.drivers,
                          onDeleteAction: onDeleteAction,
                          onShowAction: onShowAction,
                          onUpdateAction: onUpdateAction,
                        );
                      }
                      return ListView.builder(
                        itemCount: state.drivers.length,
                        itemBuilder: (BuildContext context, int index) =>
                            DriverCard(
                          state.drivers[index],
                          onDeleteAction: onDeleteAction,
                          onShowAction: onShowAction,
                          onUpdateAction: onUpdateAction,
                        ),
                      );
                    }
                    return Center(
                        child: ShowLoading(
                      tryAgain: () =>
                          context.read<DriversCubit>().refreshDrivers(),
                    ));
                  }),
            )
          ],
        ),
      ),
    );
  }

  void onShowAction(Driver driver) {
    routeShowDriver.pushId(context, driver.id.toString(), driver);
  }

  void onUpdateAction(Driver driver) {
    routeUpdateDriver.pushId(context, driver.id.toString(), driver);
  }

  void onDeleteAction(Driver driver) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => const DeleteAlertDialog(),
    ).then((bool? value) async {
      if (value ?? false) {
        await context.read<DriversCubit>().deleteDriver(driver);
        context.read<DriversCubit>().refreshDrivers();
      }
    });
  }

  void _createDriver() {
    routeStoreDriver.push(context);
  }
}
