import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/di/injector.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/user.dart';
import 'package:rg_track/service/auth/auth_service.dart';
import 'package:rg_track/service/notification/firebase_messaging_service.dart';
import 'package:rg_track/ui/auth/controller/auth_state.dart';
import 'package:rg_track/usecase/user/user_update_usecase.dart';

class AuthController extends ValueNotifier<AuthState> {
  final ValueNotifier<bool> persistNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> showPasswordNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> logging = ValueNotifier<bool>(false);

  AuthController() : super(AuthInitialState());

  void changePasswordVisibility(bool bool) {
    showPasswordNotifier.value = bool;
  }

  Future<void> loginGoogle() async {
    value = const LoadingAuthState();

    await AuthService.instance.signInWithGoogle().fold((success) {
      value = LoggedAuthState(success);
    }, (error) {
      value = ErrorLoginAuthState(error);
    });
  }

  Future<void> loginEmailPassword(String email, String password) async {
    value = const LoadingAuthState();

    try {
      await AuthService.instance.signInPassword(email, password).fold(
          (success) {
        value = LoggedAuthState(success);
      }, (error) {
        value = ErrorLoginAuthState(error);
      });
    } catch (e) {
      value = ErrorLoginAuthState(
          ErrorEntity(code: EnumErrorCode.unknown, message: e.toString()));
    }
  }

  void forgotPassword(String login) async {
    try {} on Exception {}
  }

  UserEntity get user {
    return AuthService.instance.user;
  }

  Future<bool> checkLogin() async {
    value = const LoadingAuthState();
    try {
      if (user.authorized) {
        value = LoggedAuthState(user);

        await _updateNotificationToken(user);
        return true;
      } else {
        value = AuthInitialState();
        return false;
      }
    } catch (err) {
      value = ErrorLoginAuthState(
          ErrorEntity(code: EnumErrorCode.unknown, message: err.toString()));

      return false;
    }
  }

  Future<void> logout() async {
    value = const LoadingAuthState();
    try {
      await AuthService.instance.signOut();
      value = AuthInitialState();
    } catch (err) {
      value = ErrorLoginAuthState(
          ErrorEntity(code: EnumErrorCode.unknown, message: err.toString()));
    } finally {
      value = AuthInitialState();
    }
  }

  Future<void> _updateNotificationToken(UserEntity user) async {
    if (!kIsWeb) {
      String? value =
          await getIt<FirebaseMessagingService>().getDeviceFirebaseToken();

      if (value != null) {
        if (value.isNotEmpty) {
          await UserUpdateUsecase().call(UserEntity.login(
            email: user.email,
            id: user.id,
            notificationToken: value,
          ));
          // await getIt<FirebaseMessagingService>().sendMessage(value);
        }
      }
    }
  }
}
