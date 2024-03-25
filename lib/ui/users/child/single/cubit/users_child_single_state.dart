import 'package:equatable/equatable.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/user.dart';

abstract class UserChildSingleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserChildSingleInitialState extends UserChildSingleState {}

class UserChildSingleLoadingState extends UserChildSingleState {}

class UserChildSingleSuccessfulState extends UserChildSingleState {
  final UserEntity user;

  UserChildSingleSuccessfulState(this.user);

  @override
  List<Object> get props => [user];
}

class UserChildSingleErrorState extends UserChildSingleState {
  final ErrorEntity error;

  UserChildSingleErrorState(this.error);

  @override
  List<Object> get props => [error];
}
