import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/model/plan.dart';
import 'package:rg_track/ui/plans/cubit/plans_cubit.dart';
import 'package:rg_track/ui/plans/cubit/plans_state.dart';
import 'package:rg_track/ui/plans/plan_form.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';
import 'package:rg_track/ui/widget/show_error.dart';
import 'package:rg_track/ui/widget/show_loading.dart';
import 'package:rg_track/utils/context_extension.dart';

class ShowPlanScreen extends StatefulWidget {
  final String? id;
  final Plan? plan;

  const ShowPlanScreen({
    Key? key,
    this.id,
    this.plan,
  }) : super(key: key);

  @override
  State<ShowPlanScreen> createState() => _ShowPlanScreenState();
}

class _ShowPlanScreenState extends State<ShowPlanScreen> {
  @override
  void initState() {
    if (widget.plan == null && widget.id != null) {
      context.read<PlansCubit>().showPlan(widget.id!);
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
      body: BlocBuilder<PlansCubit, PlansState>(
        builder: (BuildContext context, PlansState state) {
          if (widget.plan != null) {
            return AppBody(
              title: "Dados do Plano",
              child: PlanForm(
                plan: widget.plan,
                enable: false,
              ),
            );
          }
          if (state is PlanLoadedState) {
            return AppBody(
              title: "Dados do Plano",
              child: PlanForm(
                plan: state.plan,
                enable: false,
              ),
            );
          }
          if (state is PlanFailsState) {
            return ShowError(state.exception);
          }
          return Center(
            child: ShowLoading(tryAgain: () async {
              if (widget.plan == null && widget.id != null) {
                await context.read<PlansCubit>().showPlan(widget.id!);
              }
            }),
          );
        },
      ),
    );
  }
}
