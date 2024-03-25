import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/permissions.dart';
import 'package:rg_track/model/user.dart';
import 'package:rg_track/ui/customers/route.dart';
import 'package:rg_track/ui/dashboard/route.dart';
import 'package:rg_track/ui/devices/route.dart';
import 'package:rg_track/ui/drivers/cubit/drivers_cubit.dart';
import 'package:rg_track/ui/drivers/index_drivers_page.dart';
import 'package:rg_track/ui/events/index_vehicle_event_page.dart';
import 'package:rg_track/ui/main/ui/widget/menu_item.dart';
import 'package:rg_track/ui/plans/cubit/plans_cubit.dart';
import 'package:rg_track/ui/plans/index_plan_page.dart';
import 'package:rg_track/ui/reports/moving_stop/route.dart';
import 'package:rg_track/ui/users/route.dart';
import 'package:rg_track/ui/vehicles/route.dart';
import 'package:rg_track/ui/widget/disable_widget.dart';
import 'package:rg_track/utils/go_route_extension.dart';

class MenuItems extends StatelessWidget {
  final bool isMini;
  final Function(Widget widget, Permission title) onChange;
  final Permission? currentSelected;
  final UserEntity user;

  const MenuItems({
    super.key,
    this.isMini = false,
    required this.onChange,
    this.currentSelected,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ItemMenu(
          enabled: user.can(Permission.dashboard),
          icon: MdiIcons.viewDashboard,
          iconSelected: MdiIcons.viewDashboard,
          title: 'Dashboard',
          selected: _isSelected(Permission.dashboard),
          onTap: () {
            routeDashboard.go(context);
          },
          mini: isMini,
        ),
        ExpansionTile(
          leading: Tooltip(
              message: 'Administração', child: Icon(MdiIcons.cogOutline)),
          title: Text(isMini ? '' : 'Administração', maxLines: 1),
          children: [
            ItemMenu(
              enabled: user.can(Permission.devices),
              icon: MdiIcons.devices,
              title: Permission.devices.name,
              mini: isMini,
              selected: _isSelected(Permission.devices),
              onTap: () {
                routeListDevices.go(context);
              },
            ),
            ItemMenu(
              enabled: user.can(Permission.customers),
              icon: MdiIcons.accountMultipleOutline,
              title: Permission.customers.name,
              mini: isMini,
              selected: _isSelected(Permission.customers),
              onTap: () {
                routeListCustomers.go(context);
              },
            ),
            Disable(
              child: ItemMenu(
                title: Permission.vehicleEvent.name,
                icon: MdiIcons.formatListBulleted,
                mini: isMini,
                enabled: user.can(Permission.vehicleEvent),
                selected: _isSelected(Permission.vehicleEvent),
                onTap: () {
                  onChange(
                      const IndexVehicleEventsPage(), Permission.vehicleEvent);
                },
              ),
            ),
          ],
        ),
        Disable(
          child: ItemMenu(
            title: Permission.finesAlert.name,
            icon: MdiIcons.alert,
            mini: isMini,
            enabled: user.can(Permission.finesAlert),
            selected: _isSelected(Permission.finesAlert),
            onTap: () {},
          ),
        ),
        ItemMenu(
          title: Permission.users.name,
          icon: MdiIcons.accountMultipleOutline,
          iconSelected: MdiIcons.accountMultiple,
          mini: isMini,
          enabled: user.can(Permission.users),
          selected: _isSelected(Permission.users),
          onTap: () {
            routeListUsers.go(context);
          },
        ),
        Disable(
          absorbPointer: false,
          child: ExpansionTile(
            leading: Tooltip(
                message: Permission.config.name, child: Icon(MdiIcons.cog)),
            title: Text(isMini ? '' : Permission.config.name, maxLines: 1),
            children: [
              Disable(
                child: ItemMenu(
                  title: Permission.plans.name,
                  icon: MdiIcons.accountMultipleOutline,
                  iconSelected: MdiIcons.cash,
                  mini: isMini,
                  selected: _isSelected(Permission.plans),
                  enabled: user.can(Permission.plans),
                  onTap: () {
                    onChange(
                        BlocProvider<PlansCubit>(
                          create: (BuildContext context) =>
                              context.read<PlansCubit>(),
                          child: const IndexPlansPage(),
                        ),
                        Permission.plans);
                  },
                ),
              ),
            ],
          ),
        ),
        ExpansionTile(
          leading: Tooltip(
              message: 'Frotas e veículos', child: Icon(MdiIcons.carMultiple)),
          title: Text(isMini ? '' : 'Frotas e veículos', maxLines: 1),
          children: [
            ItemMenu(
              title: Permission.vehicles.name,
              icon: MdiIcons.carArrowRight,
              mini: isMini,
              selected: _isSelected(Permission.vehicles),
              enabled: user.can(Permission.vehicles),
              onTap: () {
                routeListVehicle.go(context);
              },
            ),
            Disable(
              child: ItemMenu(
                title: Permission.expenses.name,
                icon: MdiIcons.currencyUsd,
                mini: isMini,
                selected: _isSelected(Permission.expenses),
                enabled: user.can(Permission.expenses),
                onTap: () {},
              ),
            ),
            Disable(
              child: ItemMenu(
                title: Permission.outputControl.name,
                icon: MdiIcons.swapHorizontal,
                mini: isMini,
                selected: _isSelected(Permission.outputControl),
                enabled: user.can(Permission.outputControl),
                onTap: () {},
              ),
            ),
            Disable(
              child: ItemMenu(
                title: Permission.maintenances.name,
                icon: MdiIcons.tools,
                mini: isMini,
                selected: _isSelected(Permission.maintenances),
                enabled: user.can(Permission.maintenances),
                onTap: () {},
              ),
            ),
            Disable(
              child: ItemMenu(
                title: Permission.config.name,
                icon: MdiIcons.cogOutline,
                iconSelected: MdiIcons.cog,
                mini: isMini,
                selected: _isSelected(Permission.config),
                enabled: user.can(Permission.config),
                onTap: () {},
              ),
            ),
            Disable(
              child: ItemMenu(
                title: Permission.vehicleReport.name,
                icon: MdiIcons.fileChartOutline,
                iconSelected: MdiIcons.fileChart,
                mini: isMini,
                selected: _isSelected(Permission.vehicleReport),
                enabled: user.can(Permission.vehicleReport),
                onTap: () {},
              ),
            ),
          ],
        ),
        Disable(
          child: ItemMenu(
            title: Permission.drivers.name,
            icon: MdiIcons.cardAccountDetailsOutline,
            iconSelected: MdiIcons.cardAccountDetails,
            mini: isMini,
            selected: _isSelected(Permission.drivers),
            enabled: user.can(Permission.drivers),
            onTap: () {
              onChange(
                  BlocProvider<DriversCubit>(
                    create: (BuildContext context) =>
                        context.read<DriversCubit>(),
                    child: const IndexDriversPage(),
                  ),
                  Permission.drivers);
            },
          ),
        ),
        Disable(
          child: ItemMenu(
            title: Permission.journey.name,
            icon: MdiIcons.clockTimeFiveOutline,
            mini: isMini,
            selected: _isSelected(Permission.journey),
            enabled: user.can(Permission.journey),
            onTap: () {},
          ),
        ),
        Disable(
          absorbPointer: false,
          child: ExpansionTile(
            leading: Tooltip(
                message: 'Financeiro', child: Icon(MdiIcons.currencyUsd)),
            title: Text(isMini ? '' : 'Financeiro', maxLines: 1),
            children: [
              Disable(
                child: ItemMenu(
                  title: Permission.config.name,
                  icon: MdiIcons.cog,
                  mini: isMini,
                  selected: _isSelected(Permission.config),
                  enabled: user.can(Permission.config),
                  onTap: () {},
                ),
              ),
              Disable(
                child: ItemMenu(
                  icon: MdiIcons.history,
                  title: Permission.history.name,
                  mini: isMini,
                  enabled: user.can(Permission.history),
                  selected: _isSelected(Permission.history),
                  onTap: () {},
                ),
              ),
              Disable(
                child: ItemMenu(
                  title: Permission.secondTicket.name,
                  icon: MdiIcons.ticketConfirmation,
                  mini: isMini,
                  enabled: user.can(Permission.secondTicket),
                  selected: _isSelected(Permission.secondTicket),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
        ExpansionTile(
          leading: Tooltip(
              message: 'Relatórios', child: Icon(MdiIcons.fileChartOutline)),
          title: Text(isMini ? '' : 'Relatórios', maxLines: 1),
          children: [
            ItemMenu(
              icon: MdiIcons.trafficLightOutline,
              iconSelected: MdiIcons.trafficLight,
              title: Permission.reportMovingAndStop.name,
              onTap: () {
                routeAnalyticReport.go(context);
              },
              mini: isMini,
              enabled: true,
              selected: _isSelected(Permission.reportMovingAndStop),
            ),
          ],
        ),
        Disable(
          child: ItemMenu(
            title: Permission.sinistro.name,
            icon: MdiIcons.carTractionControl,
            mini: isMini,
            selected: _isSelected(Permission.sinistro),
            enabled: user.can(Permission.sinistro),
            onTap: () {},
          ),
        ),
        Disable(
          absorbPointer: false,
          child: ExpansionTile(
            leading: Icon(MdiIcons.toolbox),
            title: Text(isMini ? '' : 'Utilitários', maxLines: 1),
            children: [
              Disable(
                child: ListTile(
                  enabled: false,
                  leading: Icon(MdiIcons.viewDashboardOutline),
                  title: isMini
                      ? null
                      : const Text('Personalização dashboard', maxLines: 1),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  bool _isSelected(Permission selection) => currentSelected == selection;
}
