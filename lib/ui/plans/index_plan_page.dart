import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:rg_track/model/plan.dart';
import 'package:rg_track/ui/plans/cubit/plans_cubit.dart';
import 'package:rg_track/ui/plans/cubit/plans_state.dart';
import 'package:rg_track/ui/plans/route.dart';
import 'package:rg_track/ui/plans/widget/plan_card.dart';
import 'package:rg_track/ui/plans/widget/plan_table_view.dart';
import 'package:rg_track/ui/widget/delete_alert_dialog.dart';
import 'package:rg_track/ui/widget/message.dart';
import 'package:rg_track/ui/widget/show_loading.dart';
import 'package:rg_track/utils/context_extension.dart';
import 'package:rg_track/utils/debounce.dart';
import 'package:rg_track/utils/go_route_extension.dart';
import 'package:rg_track/utils/screen_utils.dart';

class IndexPlansPage extends StatefulWidget {
  const IndexPlansPage({super.key});

  @override
  State<IndexPlansPage> createState() => _IndexPlansPageState();
}

class _IndexPlansPageState extends State<IndexPlansPage> {
  late final PlansCubit _cubit;
  final Debounce _debounce250 = Debounce(const Duration(milliseconds: 250));
  final TextEditingController _searchCtrl = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  @override
  void initState() {
    _cubit = context.read<PlansCubit>();
    _cubit.refreshPlans(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _createPlan,
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
                    controller: _searchCtrl,
                    focusNode: _searchFocus,
                    decoration: const InputDecoration(
                        hintText: 'Qual plano está buscando?'),
                    onChanged: (String value) {
                      _debounce250.debounce(() => _cubit.searchPlans(value));
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<PlansCubit, PlansState>(
                  buildWhen: (PlansState previous, PlansState current) =>
                      current is PlanListedState ||
                      current is PlanListSearchNotFoundState,
                  builder: (BuildContext context, PlansState state) {
                    if (state is PlanListedState) {
                      if (state.plans.isEmpty) {
                        return Message(
                          title: 'Nenhum plano por aqui ainda.',
                          body: 'Você pode cadastrar um agora.',
                          icon: MdiIcons.accountMultiple,
                          action: _createPlan,
                          actionText: 'Novo plano',
                          secondActionText: 'Recarregar',
                          secondAction: () =>
                              context.read<PlansCubit>().refreshPlans(true),
                        );
                      }
                      if (isWideScreen(context)) {
                        return PlansTableView(
                          state.plans,
                          onDeleteAction: onDeleteAction,
                          onShowAction: onShowAction,
                          onUpdateAction: onUpdateAction,
                        );
                      }
                      return ListView.builder(
                        itemCount: state.plans.length,
                        itemBuilder: (BuildContext context, int index) =>
                            PlanCard(
                          state.plans[index],
                          onDeleteAction: onDeleteAction,
                          onShowAction: onShowAction,
                          onUpdateAction: onUpdateAction,
                        ),
                      );
                    }
                    if (state is PlanListSearchNotFoundState) {
                      return Message(
                        title: state.message,
                        body: 'Tente buscar outro plano.'
                            '\n'
                            'ou cadastre um agora.',
                        icon: MdiIcons.accountMultiple,
                        action: _searchAgain,
                        actionText: 'Buscar outro',
                        secondActionText: 'Novo plano',
                        secondAction: _createPlan,
                      );
                    }
                    return Center(
                        child: ShowLoading(
                      tryAgain: () => context.read<PlansCubit>().refreshPlans(),
                    ));
                  }),
            )
          ],
        ),
      ),
    );
  }

  void onShowAction(Plan plan) {
    routeShowPlan.pushId(context, plan.id.toString(), plan);
  }

  void onUpdateAction(Plan plan) {
    routeUpdatePlan.pushId(context, plan.id.toString(), plan);
  }

  void onDeleteAction(Plan plan) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) => const DeleteAlertDialog(),
    ).then((bool? value) async {
      if (value ?? false) {
        await context.read<PlansCubit>().deletePlan(plan);
        context.read<PlansCubit>().refreshPlans(true);
      }
    });
  }

  void _createPlan() {
    routeStorePlan.go(context);
  }

  void _searchAgain() {
    _searchCtrl.clear();
    _searchFocus.requestFocus();
  }
}
