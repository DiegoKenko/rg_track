import 'dart:convert';

import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/service/flespi/device/message/flespi_channel_message.dart';
import 'package:rg_track/service/flespi/flespi_base.dart';
import 'package:rg_track/service/flespi/flespi_service_multiple.dart';

class FlespiServiceChannelMessage {
  final String _baseUrl = flespiBasePath + flespiDevicePath;
  final String _messagePath = flespiMessagePath;
  final FlespiServiceMultiple _flespiServiceMultiple = FlespiServiceMultiple();
  FlespiServiceChannelMessage() {}

  Future<Result<List<FlespiChannelMessage>, ErrorEntity>> getMessages(
    String deviceId, {
    int limit = 100,
    bool reverse = false,
    bool positionValid = true,
  }) async {
    return await _flespiServiceMultiple.get(
      _baseUrl + '/' + deviceId + _messagePath,
      params: {
        "data": const JsonEncoder().convert({
          "count": limit,
          "reverse": reverse,
          "filter": "position.valid=true"
        })
      },
    ).fold((success) {
      List<Map<String, dynamic>> json =
          success.map((e) => Map.from(e).cast<String, dynamic>()).toList();
      return json
          .map((x) => FlespiChannelMessage.fromMap(x))
          .toList()
          .toSuccess();
    }, (error) => error.toFailure());
  }
}
