import 'package:intl/intl.dart';

class DateController {
  String dateTimeToString(DateTime dateTime) {
    return DateFormat('dd/MM/y').format(dateTime);
  }

  DateTime stringToDateTime(String dateString) {
    String date = dateString.replaceAll('/', '');
    date = date.substring(4, 8) + date.substring(2, 4) + date.substring(0, 2);
    return DateTime.parse(date);
  }

  /// return true if date < end
  bool isBefore(DateTime date, DateTime end) {
    return date.isBefore(end);
  }

  /// return true if date > start
  bool isAfter(DateTime date, DateTime start) {
    return date.isAfter(start);
  }

  /// return true if start < date < end
  bool isBetween(DateTime date, DateTime start, DateTime end) {
    return date.isAfter(start) && date.isBefore(end);
  }
}
