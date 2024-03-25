import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/di/injector.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/model/error_entity.dart';

class DeviceUpdateDatasource {
  final FirebaseFirestore _firestore = getIt<FirebaseFirestore>();

  Future<Result<Device, ErrorEntity>> update(Device device) async {
    try {
      await _firestore
          .collection('devices')
          .doc(device.id)
          .update(device.toMap());
      return device.toSuccess();
    } catch (e) {
      return ErrorEntity(code: EnumErrorCode.e04210, message: e.toString())
          .toFailure();
    }
  }
}
