import 'package:dio/dio.dart';

BaseOptions buildBaseOptions(String baseUrl) {
  return BaseOptions(
    headers: {
      'Accept': 'application/json',
      'Accept-Language': 'pt_BR',
    },
    baseUrl: baseUrl,
    contentType: 'application/json',
    connectTimeout: const Duration(seconds: 5).inMilliseconds,
    receiveTimeout: const Duration(seconds: 15).inMilliseconds,
    sendTimeout: const Duration(seconds: 5).inMilliseconds,
  );
}
