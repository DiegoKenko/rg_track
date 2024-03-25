import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/user.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/ui/users/child/single/cubit/users_child_single_state.dart';
import 'package:rg_track/usecase/user/user_create_usecase.dart';
import 'package:rg_track/usecase/user/user_get_usecase.dart';
import 'package:rg_track/usecase/user/user_update_usecase.dart';

class UserChildSingleCubit extends Cubit<UserChildSingleState> {
  final UserUpdateUsecase _userUpdateUsecase = UserUpdateUsecase();
  final UserCreateUsecase _userCreateUsecase = UserCreateUsecase();
  final UserGetUsecase _userGetUsecase = UserGetUsecase();

  UserChildSingleCubit() : super(UserChildSingleInitialState());

  Future<void> loadUser(String id) async {
    emit(UserChildSingleLoadingState());
    try {
      await _userGetUsecase.call(id).fold((success) {
        emit(UserChildSingleSuccessfulState(success));
      }, (error) {
        emit(UserChildSingleErrorState(ErrorEntity.empty()));
      });
    } on Exception {
      emit(UserChildSingleErrorState(ErrorEntity.empty()));
    }
  }

  Future<UserEntity?> update(UserEntity user) async {
    emit(UserChildSingleLoadingState());
    if (user.email == null) {
      return null;
    }
    try {
      await _userUpdateUsecase.call(user);
      emit(UserChildSingleSuccessfulState(user));
      return user;
    } on Exception {
      emit(UserChildSingleErrorState(ErrorEntity.empty()));
      return null;
    }
  }

  Future<UserEntity?> createUser(UserEntity user) async {
    emit(UserChildSingleLoadingState());
    try {
      if (user.email != null) {
        return await _userCreateUsecase.call(user).fold((success) {
          emit(UserChildSingleSuccessfulState(success));
          return success;
        }, (error) {
          emit(UserChildSingleErrorState(ErrorEntity.empty()));
          return null;
        });
      }
      return user;
    } on Exception {
      emit(UserChildSingleErrorState(ErrorEntity.empty()));
      return null;
    }
  }
}
