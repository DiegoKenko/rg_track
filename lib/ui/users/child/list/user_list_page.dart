import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/permissions.dart';
import 'package:rg_track/model/user.dart';
import 'package:rg_track/service/auth/auth_service.dart';
import 'package:rg_track/ui/main/ui/widget/app_drawer.dart';
import 'package:rg_track/ui/users/child/list/cubit/users_child_list_cubit.dart';
import 'package:rg_track/ui/users/child/list/cubit/users_child_list_state.dart';
import 'package:rg_track/ui/users/route.dart';
import 'package:rg_track/ui/users/child/list/user_card.dart';
import 'package:rg_track/ui/users/child/list/users_table_view.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';
import 'package:rg_track/ui/widget/delete_alert_dialog.dart';
import 'package:rg_track/ui/widget/message.dart';
import 'package:rg_track/ui/widget/show_loading.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/go_route_extension.dart';
import 'package:rg_track/utils/screen_utils.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createUser(),
        child: Icon(MdiIcons.plus),
      ),
      drawer: AppDrawer(
        onChange: (_, p) {},
        currentSelected: Permission.users,
      ),
      body: AppBody(
        title: 'Usuários',
        child: Container(
          margin: EdgeInsets.only(
              top: context.onWideScreen(20, 20)!,
              right: context.onWideScreen(150, 16)!,
              left: context.onWideScreen(150, 16)!),
          child: Column(
            children: [
              /*  Row(
                children: [
                  const Spacer(),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 350),
                    padding: const EdgeInsets.only(top: 10, bottom: 8),
                    child: TextFormField(
                      controller: _searchCtrl,
                      focusNode: _searchFocus,
                      decoration: const InputDecoration(
                          hintText: 'Qual usuário está buscando?'),
                      onChanged: (String value) {
                        _debounce250.debounce(() =>
                            context.read<UserChildListCubit>().search(value));
                      },
                    ),
                  ),
                ],
              ), */
              Expanded(
                child: BlocBuilder<UserChildListCubit, UserChildListState>(
                    bloc: context.read<UserChildListCubit>()
                      ..init(AuthService.instance.user.id ?? ''),
                    builder: (BuildContext context, UserChildListState state) {
                      if (state is UserChildListSuccessfulState) {
                        if (state.users.isEmpty) {
                          return Message(
                            title: 'Nenhum usuário por aqui.',
                            body: 'Você pode cadastrar um agora.',
                            icon: MdiIcons.accountMultiple,
                            action: _createUser,
                            actionText: 'Novo usuário',
                          );
                        }
                        if (isWideScreen(context)) {
                          return UsersTableView(
                            state.users,
                            onDeleteAction: onDeleteAction,
                            onShowAction: onShowAction,
                            onUpdateAction: onUpdateAction,
                            onStatusChangeAction: (UserEntity model) {},
                          );
                        }
                        return RefreshIndicator(
                          onRefresh: () async {
                            await context
                                .read<UserChildListCubit>()
                                .refreshUsers(
                                    AuthService.instance.user.id ?? '');
                          },
                          child: ListView.builder(
                            itemCount: state.users.length,
                            itemBuilder: (BuildContext context, int index) =>
                                UserCard(
                              state.users[index],
                              onDeleteAction: onDeleteAction,
                              onShowAction: onShowAction,
                              onUpdateAction: onUpdateAction,
                            ),
                          ),
                        );
                      }

                      return Center(
                        child: ShowLoading(
                          tryAgain: () => context
                              .read<UserChildListCubit>()
                              .refreshUsers(AuthService.instance.user.id ?? ''),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onShowAction(UserEntity user) {
    routeShowUser.pushId(context, user.id, user);
  }

  void onUpdateAction(UserEntity user) async {
    routeUpdateUser.pushId(context, user.id, user);
    await context
        .read<UserChildListCubit>()
        .refreshUsers(AuthService.instance.user.id ?? '');
  }

  void onDeleteAction(UserEntity user) async {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => const DeleteAlertDialog(),
    ).then((bool? value) async {
      if (value ?? false) {
        await context.read<UserChildListCubit>().deleteUser(user);
        await context
            .read<UserChildListCubit>()
            .refreshUsers(AuthService.instance.user.id ?? '');
      }
    });
  }

  Future<void> _createUser() async {
    await routeStoreUser.push(context).then((value) async {
      context
          .read<UserChildListCubit>()
          .refreshUsers(AuthService.instance.user.id ?? '');
    });
  }
}
