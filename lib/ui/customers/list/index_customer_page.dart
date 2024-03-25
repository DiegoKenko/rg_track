import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/permissions.dart';
import 'package:rg_track/service/auth/auth_service.dart';
import 'package:rg_track/ui/customers/list/cubit/customer_list_cubit.dart';
import 'package:rg_track/ui/customers/list/cubit/customer_list_state.dart';
import 'package:rg_track/ui/customers/route.dart';
import 'package:rg_track/ui/customers/widget/customer_card.dart';
import 'package:rg_track/ui/customers/list/customer_table_view.dart';
import 'package:rg_track/ui/main/ui/widget/app_drawer.dart';
import 'package:rg_track/ui/widget/alert_dialog_fails.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';
import 'package:rg_track/ui/widget/delete_alert_dialog.dart';
import 'package:rg_track/ui/widget/message.dart';
import 'package:rg_track/ui/widget/show_loading.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/go_route_extension.dart';
import 'package:rg_track/utils/screen_utils.dart';

class IndexCustomersPage extends StatefulWidget {
  const IndexCustomersPage({super.key});

  @override
  State<IndexCustomersPage> createState() => _IndexCustomersPageState();
}

class _IndexCustomersPageState extends State<IndexCustomersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _createOne,
        child: Icon(MdiIcons.plus),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: SizedBox(
          height: 30,
          child: AppLogo.horizontal(),
        ),
      ),
      drawer: AppDrawer(
        onChange: (_, p) {},
        currentSelected: Permission.customers,
      ),
      body: AppBody(
        title: 'Clientes',
        child: Container(
          margin: EdgeInsets.only(
              top: context.onWideScreen(20, 20)!,
              right: context.onWideScreen(150, 16)!,
              left: context.onWideScreen(150, 16)!),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /*  Container(
                constraints: const BoxConstraints(maxWidth: 350),
                padding: const EdgeInsets.only(top: 10, bottom: 8),
                child: TextFormField(
                  controller: _searchCtrl,
                  focusNode: _searchFocus,
                  decoration: const InputDecoration(
                      hintText: 'Qual cliente está buscando?'),
                  onChanged: (String value) {},
                ),
              ), */
              Expanded(
                child: BlocBuilder<CustomerListCubit, CustomerListState>(
                  bloc: context.read<CustomerListCubit>()
                    ..load(AuthService.instance.user.id ?? ''),
                  builder: (BuildContext context, CustomerListState state) {
                    if (state is CustomerListSuccessState) {
                      if (state.customers.isEmpty) {
                        return Message(
                          title: 'Nenhum cliente por aqui ainda.',
                          body: 'Você pode cadastrar um agora.',
                          icon: MdiIcons.accountMultipleOutline,
                          action: _createOne,
                          actionText: 'Novo cliente',
                        );
                      }
                      if (isWideScreen(context)) {
                        return CustomersTableView(
                          state.customers,
                          onDeleteAction: _onDeleteAction,
                          onShowAction: _onShowAction,
                          onUpdateAction: _onUpdateAction,
                        );
                      }
                      return ListView.builder(
                        itemCount: state.customers.length,
                        itemBuilder: (BuildContext context, int index) =>
                            CustomerCard(
                          state.customers[index],
                          onDeleteAction: _onDeleteAction,
                          onShowAction: _onShowAction,
                          onUpdateAction: _onUpdateAction,
                        ),
                      );
                    }
                    return Center(
                      child: ShowLoading(
                        tryAgain: () async {},
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onShowAction(Customer customer) {
    routeShowCustomer.pushId(context, customer.id, customer);
  }

  Future<void> _onUpdateAction(Customer customer) async {
    await routeUpdateCustomer.pushId(context, customer.id, customer);

    context.read<CustomerListCubit>()
      .load(AuthService.instance.user.id ?? '');
  }

  void _onDeleteAction(Customer customer) async {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => const DeleteAlertDialog(),
    ).then((bool? value) async {
      if (value ?? false) {
        ErrorEntity error = ErrorEntity.empty();
        await context
            .read<CustomerListCubit>()
            .delete(customer)
            .fold((success) {}, (e) => error = e);
        if (!error.isEmpty) {
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialogFails(exception: error));
        }
        context.read<CustomerListCubit>()
          .load(AuthService.instance.user.id ?? '');
      }
    });
  }

  Future<void> _createOne() async {
    await routeStoreCustomer.push(context);
    context.read<CustomerListCubit>()
      .load(AuthService.instance.user.id ?? '');
  }
}
