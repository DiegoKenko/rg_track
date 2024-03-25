import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/datasource/user/user_datasource.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/user.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/users/parent/cubit/users_parent_state.dart';

class UserParentCubit extends Cubit<UserParentState> {
  final UserDatasource _userDatasource = UserDatasource();

  UserParentCubit() : super(UserParentInitialState());

  Future<void> init(String id) async {
    emit(UserParentLoadingState());

    await _userDatasource.getUser(id).fold((success) {
      emit(UserParentSuccessfulState(success));
    }, (error) {
      emit(UserParentErrorState(ErrorEntity.empty()));
    });
  }

  Future deleteUser(User User) async {}

  Future<List<User>> refreshUsers([bool initial = false]) async {
    emit(UserParentLoadingState());
    try {} on Exception {}
    return [];
  }

  Future<List<User>> search(String value) async {
    if (value.isEmpty) {
      return refreshUsers();
    }

    return [];
  }

  Future<User?> showUser(String id) async {
    return null;
  }

  Future<User?> storeUser(
      UserEntity user, List<Vehicle> vehicles, Customer? customer) async {
    emit(UserParentLoadingState());

    return null;
  }
}
