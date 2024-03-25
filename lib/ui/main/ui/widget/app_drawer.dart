import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/const/theme.dart';
import 'package:rg_track/model/di/injector.dart';
import 'package:rg_track/model/permissions.dart';
import 'package:rg_track/model/user.dart';
import 'package:rg_track/service/auth/auth_service.dart';
import 'package:rg_track/ui/auth/controller/auth_controller.dart';
import 'package:rg_track/ui/auth/route.dart';
import 'package:rg_track/ui/main/ui/widget/menu_item.dart';
import 'package:rg_track/ui/main/ui/widget/menu_items.dart';
import 'package:rg_track/ui/main/ui/widget/user_header.dart';
import 'package:rg_track/ui/users/parent/cubit/users_parent_cubit.dart';
import 'package:rg_track/ui/users/parent/cubit/users_parent_state.dart';
import 'package:rg_track/utils/go_route_extension.dart';

class AppDrawer extends StatefulWidget {
  final Function(Widget widget, Permission title) onChange;
  final Permission? currentSelected;

  const AppDrawer({
    Key? key,
    required this.onChange,
    required this.currentSelected,
  }) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final bool _isMini = false;

  Future<UserEntity> loadUser() async {
    if (AuthService.instance.user.authorized) {
      return Future.value(AuthService.instance.user);
    } else {
      UserEntity? user = await AuthService.instance.getUser();
      return Future.value(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: loadUser(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return Drawer(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    const CircularProgressIndicator(
                      color: primaryColor,
                      strokeWidth: 5,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    ItemMenu(
                      title: 'Desconectar',
                      icon: MdiIcons.logout,
                      mini: false,
                      selected: false,
                      enabled: true,
                      onTap: () {
                        routeSignIn.pushReplacement(context);
                        getIt<AuthController>().logout();
                      },
                    ),
                  ],
                ),
              );
            }
            return BlocBuilder<UserParentCubit, UserParentState>(
                bloc: getIt<UserParentCubit>()..init(snap.data!.id ?? ''),
                builder: (BuildContext context, UserParentState state) {
                  if (state is UserParentLoadingState) {
                    return AnimatedContainer(
                      width: 304.0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.decelerate,
                      child: const Drawer(
                          child: Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                          strokeWidth: 5,
                        ),
                      )),
                    );
                  }
                  if (state is UserParentSuccessfulState) {
                    return AnimatedContainer(
                      width: 304.0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.decelerate,
                      child: Drawer(
                        child: Column(
                          children: [
                            UserHeader(
                              user: state.user,
                              mini: _isMini,
                            ),
                            const Divider(
                              endIndent: 16,
                              indent: 16,
                            ),
                            /*  AnimatedSize(
                              duration: const Duration(milliseconds: 350),
                              child: CustomersDropdown(
                                customer: widget.customer,
                              )), */
                            Expanded(
                              child: MenuItems(
                                onChange: widget.onChange,
                                currentSelected: widget.currentSelected,
                                user: state.user,
                              ),
                            ),
                            ItemMenu(
                              title: 'Desconectar',
                              icon: MdiIcons.logout,
                              mini: false,
                              selected: false,
                              enabled: true,
                              onTap: () {
                                routeSignIn.pushReplacement(context);
                                getIt<AuthController>().logout();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Drawer(
                    child: Column(
                      children: [
                        ItemMenu(
                          title: 'Desconectar',
                          icon: MdiIcons.logout,
                          mini: false,
                          selected: false,
                          enabled: true,
                          onTap: () {
                            getIt<AuthController>().logout();
                            routeSignIn.pushReplacement(context);
                          },
                        ),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
