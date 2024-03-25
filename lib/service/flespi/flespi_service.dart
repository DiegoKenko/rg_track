import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/di/injector.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/secret.dart';

class FlespiService {
  FlespiService();
  Dio dio = getIt<Dio>();

  Future<Result<Map<String, dynamic>, ErrorEntity>> get(
    String url, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    dio.options = BaseOptions(
      headers: _addToken(headers ?? {}),
      queryParameters: params,
    );
    try {
      Response response = await dio.get(url);
      return _convertResponse(response);
    } on DioError catch (e) {
      return ErrorEntity(
              code: EnumErrorCode.e04502, message: e.response.toString())
          .toFailure();
    } catch (e) {
      return ErrorEntity(code: EnumErrorCode.e04501, message: e.toString())
          .toFailure();
    }
  }

  Future<Result<Map<String, dynamic>, ErrorEntity>> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    dio.options = BaseOptions(
      headers: _addToken(headers ?? {}),
      queryParameters: params,
    );
    try {
      Response response = await dio.post(url, data: data);
      return _convertResponse(response);
    } on DioError catch (e) {
      return ErrorEntity(
              code: EnumErrorCode.e04502, message: e.response.toString())
          .toFailure();
    } catch (e) {
      return ErrorEntity(code: EnumErrorCode.e04502, message: e.toString())
          .toFailure();
    }
  }

  Future<Result<Map<String, dynamic>, ErrorEntity>> put(
    String url, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    dio.options = BaseOptions(
      headers: _addToken(headers ?? {}),
      queryParameters: params,
    );
    try {
      Response response = await dio.put(url, data: jsonEncode([params]));
      return _convertResponse(response);
    } on DioError catch (e) {
      return ErrorEntity(
              code: EnumErrorCode.e04502, message: e.response.toString())
          .toFailure();
    } catch (e) {
      return ErrorEntity(code: EnumErrorCode.e04503, message: e.toString())
          .toFailure();
    }
  }

  Future<Result<Map<String, dynamic>, ErrorEntity>> delete(
    String url, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
  }) async {
    dio.options = BaseOptions(
      headers: _addToken(headers ?? {}),
      queryParameters: params,
    );
    try {
      Response response = await dio.delete(url);
      return _convertResponse(response);
    } on DioError catch (e) {
      return ErrorEntity(
              code: EnumErrorCode.e04502, message: e.response.toString())
          .toFailure();
    } catch (e) {
      return ErrorEntity(code: EnumErrorCode.e04504, message: e.toString())
          .toFailure();
    }
  }

  Map<String, dynamic> _addToken(Map<String, dynamic> headers) {
    headers["Authorization"] = FLESPI_TOKEN_MASTER;
    return headers;
  }

  Result<Map<String, dynamic>, ErrorEntity> _convertResponse(
    Response response,
  ) {
    try {
      if (Map.from(response.data).isNotEmpty) {
        if (Map.from(response.data).keys.contains('result')) {
          if (Map.from(response.data)['result'] is List) {
            if ((Map.from(response.data)['result'] as List).first
                is Map<String, dynamic>) {
              return Map<String, dynamic>.from(
                      (Map.from(response.data)['result'] as List).first)
                  .toSuccess();
            } else {
              return <String, dynamic>{
                'data': (Map.from(response.data)['result'] as List).first,
              }.toSuccess();
            }
          }
        }
      }
      return ErrorEntity(code: EnumErrorCode.e04520, message: ''.toString())
          .toFailure();
    } on DioError catch (e) {
      return ErrorEntity(
              code: EnumErrorCode.e04502, message: e.response.toString())
          .toFailure();
    } catch (e) {
      return ErrorEntity(code: EnumErrorCode.e04510, message: e.toString())
          .toFailure();
    }
  }
}
