import 'package:result_dart/result_dart.dart';
import 'package:rg_track/datasource/user/user_datasource.dart';

import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/user.dart';
import 'package:rg_track/service/auth/auth_service.dart';

class UserUpdateUsecase {
  Future<Result<UserEntity, ErrorEntity>> call(UserEntity userEntity) async {
    UserDatasource userDatasource = UserDatasource();
    AuthService authService = AuthService.instance;
    if (userEntity.email == null) {
      return Failure(ErrorEntity.empty());
    }

    await userDatasource.updateUser(userEntity).fold((success) async {
      userEntity = success;
    }, (error) => null);

    await authService.createAuthPassword(
        userEntity.email ?? '', userEntity.password);
    return userEntity.toSuccess();
  }
}
