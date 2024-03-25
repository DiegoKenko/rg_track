import 'package:equatable/equatable.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/plan.dart';

abstract class PlansState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlansInitial extends PlansState {}

class PlanListedState extends PlansState {
  final List<Plan> plans;

  PlanListedState(this.plans);

  @override
  List<Object> get props => [plans];
}

class PlanListErrorState extends PlansState {
  final ErrorEntity exception;

  PlanListErrorState(this.exception);

  @override
  List<Object?> get props => [exception];
}

class PlanSuccessfulState extends PlansState {
  final Plan plan;

  PlanSuccessfulState(this.plan);

  @override
  List<Object> get props => [plan];
}

class PlanLoadedState extends PlansState {
  final Plan plan;

  PlanLoadedState(this.plan);

  @override
  List<Object> get props => [plan];
}

class PlanFailsState extends PlansState {
  final ErrorEntity exception;

  PlanFailsState(this.exception);

  @override
  List<Object?> get props => [exception];
}

class PlanFailsUnKnowState extends PlansState {
  final ErrorEntity exception;

  PlanFailsUnKnowState(this.exception);

  @override
  List<Object?> get props => [exception];
}

class DeletePlanByIdState extends PlansState {
  final Plan plan;

  DeletePlanByIdState(this.plan);

  @override
  List<Object> get props => [plan];
}

class PlanLoadingState extends PlansState {}

class PlanListSearchNotFoundState extends PlansState {
  final String message;

  PlanListSearchNotFoundState(this.message);

  @override
  List<Object?> get props => [message];
}
