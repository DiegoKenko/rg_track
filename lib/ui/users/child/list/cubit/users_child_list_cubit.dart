import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/datasource/user/user_datasource.dart';
import 'package:rg_track/model/user.dart';
import 'package:rg_track/ui/users/child/list/cubit/users_child_list_state.dart';

class UserChildListCubit extends Cubit<UserChildListState> {
  final UserDatasource _userDatasource = UserDatasource();

  UserChildListCubit() : super(UserChildListInitialState());

  Future<void> init(String userParentId) async {
    List<UserEntity> users = await _userDatasource.getUsers(userParentId);
    emit(UserChildListSuccessfulState(users));
  }

  Future<void> deleteUser(UserEntity user) async {
    try {
      await _userDatasource.deleteUser(user.id ?? '');
    } on Exception {}
  }

  Future<void> refreshUsers(String userParentId) async {
    emit(UserChildListLoadingState());
    try {
      List<UserEntity> users = await _userDatasource.getUsers(userParentId);
      emit(UserChildListSuccessfulState(users));
    } on Exception catch (err) {
      emit(UserChildListErrorState(err));
    }
  }

  Future<List<User>> search(String value) async {
    emit(UserChildListLoadingState());
    if (value.isEmpty) {}
    try {} on Exception catch (err) {
      emit(UserChildListErrorState(err));
    }
    return [];
  }
}
