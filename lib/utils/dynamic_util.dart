/// Casts this objet to [T] if it is not null.
T? cast<T>(Object o) {
  return o as T;
}

/// Casts this objet to [T] or null.
T? castOrNull<T>(Object o, [T Function()? onNull]) {
  try {
    return o as T;
  } catch (e) {
    return onNull?.call();
  }
}

/// Returns the value of this object as a [bool].
bool toBool(Object o) {
  if (o is bool) return o;
  return o.toString().toLowerCase() == 'true';
}

/// Returns the value of this object as a [bool] or false if null.
bool toBoolOrFalse(Object? o) {
  if (o is bool) return o;
  return toBoolOrNull(o) ?? false;
}

/// Returns the value of this object as a [bool] or null.
bool? toBoolOrNull(Object? o) {
  if (o is bool) return o;
  return o.toString().toLowerCase() == 'true' ? true : null;
}

/// Returns the value of this object as a [bool] or true if null.
bool toBoolOrTrue(Object? o) {
  return toBoolOrNull(o) ?? true;
}

/// Returns the value of this object as a [DateTime].
DateTime toDateTime(Object o) {
  return DateTime.parse(o.toString());
}

/// Returns the value of this object as a [DateTime] or now.
DateTime toDateTimeOrNow(Object? o) {
  return DateTime.tryParse(o.toString()) ?? DateTime.now();
}

/// Returns the value of this object as a [DateTime] or null.
DateTime? toDateTimeOrNull(Object? o) {
  return DateTime.tryParse(o.toString());
}

/// Returns the value of this object as a [double].
double toDouble(Object o) {
  if (o is double) return o;
  if (o is num) return o.toDouble();
  return num.parse(o.toString()).toDouble();
}

/// Returns the value of this object as a [double].
/// If the value is null or not number, returns [onNull].
double? toDoubleOrNull(Object? o) {
  if (o is double) return o;
  if (o is num) return o.toDouble();
  return num.tryParse(o.toString())?.toDouble();
}

/// Returns the value of this object as a [int].
/// If the value is a [double], it is truncated towards zero.
int toInt(Object o) {
  if (o is int) return o;
  if (o is num) return o.toInt();
  return num.parse(o.toString()).toInt();
}

/// Returns the value of this object as a [int] or null.
/// If the value is a [double], it is truncated towards zero.
/// If the value is not a number, returns null.
int? toIntOrNull(Object? o) {
  if (o is int) return o;
  if (o is num) return o.toInt();
  return num.tryParse(o.toString())?.toInt();
}

String toString(Object o) => o.toString();

/// Returns the value of this object as a [String] or null.
String? toStringOrNull(Object? o) {
  return o?.toString();
}
