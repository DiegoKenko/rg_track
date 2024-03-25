import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/model/plan.dart';
import 'package:rg_track/ui/plans/cubit/plans_cubit.dart';
import 'package:rg_track/ui/plans/plan_form.dart';
import 'package:rg_track/ui/widget/app_body.dart';
import 'package:rg_track/ui/widget/app_logo.dart';
import 'package:rg_track/utils/context_extension.dart';

class StorePlanScreen extends StatelessWidget {
  const StorePlanScreen({super.key});

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
      body: AppBody(
        title: 'Novo Plano',
        child: PlanForm(onSave: (Plan plan) {
          context.read<PlansCubit>().storePlan(plan);
        }),
      ),
    );
  }
}
