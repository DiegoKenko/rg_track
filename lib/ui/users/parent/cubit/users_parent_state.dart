import 'package:equatable/equatable.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/user.dart';

abstract class UserParentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserParentInitialState extends UserParentState {}

class UserParentLoadingState extends UserParentState {}

class UserParentSuccessfulState extends UserParentState {
  final UserEntity user;

  UserParentSuccessfulState(this.user);

  @override
  List<Object> get props => [user];
}

class UserParentErrorState extends UserParentState {
  final ErrorEntity error;

  UserParentErrorState(this.error);

  @override
  List<Object> get props => [error];
}
