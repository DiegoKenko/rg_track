import 'package:equatable/equatable.dart';
import 'package:rg_track/model/event.dart';

abstract class LocationHistoryState extends Equatable {
  const LocationHistoryState();

  @override
  List<Object> get props => [];
}

class LocationHistoryInitial extends LocationHistoryState {}

class LocationHistoryLoading extends LocationHistoryState {}

class LocationHistoryLoaded extends LocationHistoryState {
  final List<Event> events;

  const LocationHistoryLoaded(this.events);

  @override
  List<Object> get props => [...events];
}

class LocationHistoryError extends LocationHistoryState {
  final String message;

  const LocationHistoryError(this.message);

  @override
  List<Object> get props => [message];
}
