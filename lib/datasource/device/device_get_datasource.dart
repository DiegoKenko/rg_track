import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/di/injector.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/model/error_entity.dart';

class DeviceGetDatasource {
  final FirebaseFirestore _firestore = getIt<FirebaseFirestore>();
  Future<Result<Device, ErrorEntity>> getDevice(String id) async {
    try {
      if (id.isEmpty) {
        return ErrorEntity(code: EnumErrorCode.e05104, message: '').toFailure();
      }
      DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestore.collection('devices').doc(id).get();
      if (doc.exists) {
        return Device.fromMap(doc.data()!).toSuccess();
      }
      return ErrorEntity(
              code: EnumErrorCode.e05101,
              message: 'nenhum dispositivo encontrado. ID: $id')
          .toFailure();
    } catch (e) {
      return ErrorEntity(code: EnumErrorCode.e05101, message: e.toString())
          .toFailure();
    }
  }
}
