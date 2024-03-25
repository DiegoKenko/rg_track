import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/di/injector.dart';
import 'package:rg_track/model/error_entity.dart';

class DeviceDeleteDatasource {
  final FirebaseFirestore _firestore = getIt<FirebaseFirestore>();

  Future<Result<bool, ErrorEntity>> delete(String id) async {
    try {
      await _firestore.collection('devices').doc(id).delete();
      return true.toSuccess();
    } catch (e) {
      return ErrorEntity(code: EnumErrorCode.e04210, message: e.toString())
          .toFailure();
    }
  }
}
