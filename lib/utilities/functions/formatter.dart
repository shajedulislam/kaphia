import 'package:intl/intl.dart';

import 'null_checker.dart';

class ProFormatter {
  DateTime? stringToDate(String date, String format) {
    if (!isNull(date)) {
      return DateFormat(format).parse(date);
    }
    return null;
  }

  String stringDateTimeFormatter({
    String? date,
    required String dateFormat,
    required String parseFormat,
  }) {
    if (!isNull(date)) {
      return DateFormat(dateFormat).format(stringToDate(date!, parseFormat)!);
    }
    return "";
  }

  String dateTimeFormatter({
    DateTime? dateTime,
    required String format,
  }) {
    if (!isNull(dateTime)) {
      return DateFormat(format).format(dateTime!);
    }
    return "";
  }

  DateTime utcToLocalDate(String date) {
    var dateUtc = DateTime.parse(date);
    var dateLocal = dateUtc.toLocal();
    return dateLocal;
  }

  String money({
    double? money,
    bool? showOnlyMoney,
    String? currency,
  }) {
    final formatCurrency = NumberFormat.currency(
      locale: 'en_US',
      symbol: showOnlyMoney != true
          ? !isNull(currency)
              ? "$currency "
              : ""
          : "",
      decimalDigits: 0,
    );
    return formatCurrency.format(money ?? 0);
  }
}
