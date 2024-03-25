import 'package:result_dart/result_dart.dart';
import 'package:rg_track/datasource/user/user_datasource.dart';

import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/user.dart';
import 'package:rg_track/service/auth/auth_service.dart';

class UserUpdateUsecase {
  Future<Result<UserEntity, ErrorEntity>> call(UserEntity userEntity) async {
    UserDatasource _userDatasource = UserDatasource();
    AuthService _authService = AuthService.instance;
    if (userEntity.email == null) {
      return Failure(ErrorEntity.empty());
    }

    await _userDatasource.updateUser(userEntity).fold((success) async {
      userEntity = success;
    }, (error) => null);

    await _authService.createAuthPassword(
        userEntity.email ?? '', userEntity.password);
    return userEntity.toSuccess();
  }
}
