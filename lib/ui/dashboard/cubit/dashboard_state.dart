import 'package:equatable/equatable.dart';
import 'package:rg_track/model/event.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitialState extends DashboardState {}

class DashboardLoadingState extends DashboardState {}

class DashboardErrorState extends DashboardState {}

class DashboardSuccessState extends DashboardState {
  final List<Event> events;
  final int countRedStatus;
  final int countYellowStatus;
  final int countGreenStatus;

  const DashboardSuccessState({
    required this.events,
    required this.countRedStatus,
    required this.countYellowStatus,
    required this.countGreenStatus,
  });

  @override
  List<Object> get props => [...events];
}
