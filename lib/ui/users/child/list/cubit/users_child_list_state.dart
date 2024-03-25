import 'package:equatable/equatable.dart';
import 'package:rg_track/model/user.dart';

abstract class UserChildListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserChildListInitialState extends UserChildListState {}

class UserChildListLoadingState extends UserChildListState {}

class UserChildListSuccessfulState extends UserChildListState {
  final List<UserEntity> users;

  UserChildListSuccessfulState(this.users);

  @override
  List<Object> get props => [users];
}

class UserChildListErrorState extends UserChildListState {
  final Exception error;

  UserChildListErrorState(this.error);

  @override
  List<Object> get props => [error];
}
