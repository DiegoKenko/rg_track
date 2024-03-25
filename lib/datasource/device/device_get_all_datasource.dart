import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/di/injector.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/model/error_entity.dart';

class DeviceGetAllDatasource {
  final FirebaseFirestore _firestore = getIt<FirebaseFirestore>();

  Future<Result<List<Device>, ErrorEntity>> getDevicesUser(
      String userId) async {
    try {
      if (userId.isEmpty) {
        return <Device>[].toSuccess();
      }
      QuerySnapshot<Map<String, dynamic>> doc = await _firestore
          .collection('devices')
          .where('user_id', isEqualTo: userId)
          .get();
      if (doc.docs.isNotEmpty) {
        return doc.docs
            .map((e) {
              Device device = Device.fromMap(e.data());
              device.id = e.id;
              return device;
            })
            .toList()
            .toSuccess();
      }

      return <Device>[].toSuccess();
    } catch (e) {
      return ErrorEntity(code: EnumErrorCode.e04210, message: e.toString())
          .toFailure();
    }
  }
}
