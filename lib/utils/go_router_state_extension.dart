import 'package:go_router/go_router.dart';

extension GoRouterStateExtension on GoRouterState {
  String? get id => pathParameters['id'] ?? uri.queryParameters['id'];

  T? parseExtra<T>([String? key, T? defaultValue]) {
    if (extra == null) {
      return defaultValue;
    }
    if (extra is T) {
      return extra as T;
    }
    if (key != null &&
        extra is Map<String, dynamic> &&
        (extra! as Map<String, dynamic>).containsKey(key) &&
        (extra! as Map<String, dynamic>)[key] is T) {
      return (extra! as Map<String, dynamic>)[key] as T;
    }

    if (extra is Iterable<dynamic>) {
      for (final Object item in extra! as Iterable<dynamic>) {
        if (item is T) {
          return item as T;
        }
      }
    }
    return defaultValue;
  }
}
