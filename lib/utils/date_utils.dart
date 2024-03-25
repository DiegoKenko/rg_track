import 'package:intl/intl.dart';

DateTime dateFromStringDMY(String date, [Pattern divisor = '/']) {
  List<String> values = date.split(divisor);
  return DateTime(
      int.parse(values[2]), int.parse(values[1]), int.parse(values[0]), 12);
}

String? formatDataDMY(DateTime? dateTime) {
  if (dateTime == null) return null;
  return DateFormat('dd/MM/yy').format(dateTime);
}

String? formatDataDMYHm(DateTime? dateTime) {
  if (dateTime == null) return null;
  return DateFormat('dd/MM/yy HH:mm').format(dateTime);
}

String? formatDataDMYHms(DateTime? dateTime) {
  if (dateTime == null) return null;
  return DateFormat('dd/MM/yy HH:mm:ss').format(dateTime);
}

String? formatDataHms(DateTime? dateTime) {
  if (dateTime == null) return null;
  return DateFormat('HH:mm:ss').format(dateTime);
}

extension DateFormatA on DateTime {
  String formatDataDmy() => formatDataDMY(this)!;

  String formatDataDmyHm() => formatDataDMYHm(this)!;

  String formatDataDmyHms() => formatDataDMYHms(this)!;

  String formatDataHMS() => formatDataHms(this)!;
}
