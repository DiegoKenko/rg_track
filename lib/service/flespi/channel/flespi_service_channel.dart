import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/service/flespi/channel/flespi_channel.dart';
import 'package:rg_track/service/flespi/flespi_base.dart';
import 'package:rg_track/service/flespi/flespi_service.dart';

class FlespiServiceChannel {
  final String baseChannelUrl = flespiBasePath + flespiChannelPath;
  final FlespiService flespiService = FlespiService();
  FlespiServiceChannel();

  Future<Result<FlespiChannel, ErrorEntity>> get(
    String channelId,
  ) async {
    return await flespiService
        .get(
      '$baseChannelUrl/$channelId',
    )
        .fold((success) {
      return FlespiChannel.fromMap(success).toSuccess();
    }, (error) => error.toFailure());
  }

  Future<Result<FlespiChannel, ErrorEntity>> create(
    FlespiChannel channel,
  ) async {
    return await flespiService
        .post(baseChannelUrl, data: [channel.toMap()]).fold((success) {
      return FlespiChannel.fromMap(success).toSuccess();
    }, (error) => error.toFailure());
  }

  Future<Result<bool, ErrorEntity>> delete(
    String channelId,
  ) async {
    return await flespiService
        .delete(
      '$baseChannelUrl/$channelId',
    )
        .fold((success) {
      return true.toSuccess();
    }, (error) => error.toFailure());
  }
}
