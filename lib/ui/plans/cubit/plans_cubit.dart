import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/model/pagination.dart';
import 'package:rg_track/model/plan.dart';
import 'package:rg_track/ui/plans/cubit/plans_state.dart';

class PlansCubit extends Cubit<PlansState> {
  final Map<int, List<Plan>> plans = {};
  Pagination<Plan>? currentPage;

  PlansCubit() : super(PlansInitial());

  Future<List<Plan>> nextPage() async {
    try {} on Exception {}
    return [];
  }

  Future<List<Plan>> refreshPlans([bool initial = false]) async {
    try {} on Exception {}
    return [];
  }

  Future<Plan?> storePlan(Plan plan) async {
    emit(PlanLoadingState());
    return null;
  }

  Future<Plan?> showPlan(String id) async {
    return null;
  }

  Future deletePlan(Plan plan) async {}

  Future<Plan?> updatePlan(Plan model) async {
    emit(PlanLoadingState());

    return null;
  }

  Future<List<Plan>> searchPlans(String value) async {
    return [];
  }
}
