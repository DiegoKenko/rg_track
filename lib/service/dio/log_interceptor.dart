// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

InterceptorsWrapper logInterceptor() {
  return InterceptorsWrapper(
    onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      print('------------ON REQUEST------------\n');
      print({
        '🔗 base_url': options.baseUrl,
        '🛤 path': options.path,
        '🔍 query': options.queryParameters,
        '🎛 method': options.method,
        '🎫 headers': options.headers,
        '🐐 body': options.data,
      });
      handler.next(options);
    },
    onResponse: (Response e, ResponseInterceptorHandler handler) {
      print('------------ON RESPONSE------------\n');
      print({
        '🎫 headers': e.headers,
        '🪁 statusCode': e.statusCode,
        '✉ statusMessage': e.statusMessage,
        '🎲 data': e.data,
      });
      handler.next(e);
    },
    onError: (DioError e, ErrorInterceptorHandler handler) {
      print('------------ON ERROR------------\n');
      print({
        '🎫 headers': e.response?.headers,
        '🪁 statusCode': e.response?.statusCode,
        '✉ statusMessage': e.response?.statusMessage,
        '🎲 data': e.response?.data,
      });
      handler.next(e);
    },
  );
}
