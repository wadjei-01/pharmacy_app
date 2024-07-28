import 'package:intl/intl.dart';

extension DateTimeHelper on DateTime {
  String toDateFormat() {
    return DateFormat('E d MMM, yyyy').format(this);
  }
}
