import 'package:result_dart/result_dart.dart';
import 'package:rg_track/datasource/user/user_datasource.dart';

import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/user.dart';

class UserGetUsecase {
  Future<Result<UserEntity, ErrorEntity>> call(String id) async {
    UserDatasource _userDatasource = UserDatasource();

    if (id.isEmpty) {
      return Failure(ErrorEntity.empty());
    }

    return await _userDatasource.getUser(id);
  }
}
