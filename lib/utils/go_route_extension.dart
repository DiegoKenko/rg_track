import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension GoRouteExtension on GoRoute {
  void pushReplacement(BuildContext context, [Object? extra]) {
    context.pushReplacement(path, extra: extra);
  }

  Future<T?> push<T>(BuildContext context, [Object? extra]) async {
    return context.push<T?>(path, extra: extra);
  }

  void pushReplacementId(BuildContext context, dynamic id, [Object? extra]) {
    context.pushReplacement(path.replaceAll(':id', id.toString()),
        extra: extra);
  }

  Future<T?> pushId<T>(BuildContext context, dynamic id,
      [Object? extra]) async {
    return context.push<T>(path.replaceAll(':id', id.toString()), extra: extra);
  }

  void go(BuildContext context, [Object? extra]) {
    context.go(path, extra: extra);
  }

  void goId(BuildContext context, String? id, [Object? extra]) {
    context.go(path.replaceAll(':id', id.toString()), extra: extra);
  }
}
