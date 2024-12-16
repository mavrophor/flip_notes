import 'package:intl/intl.dart';

String formatMonDateTime(DateTime date) {
  return '${DateFormat.MMMd().format(date)}, ${DateFormat.Hm().format(date)}';
}

String formatTimeDate(DateTime date) {
  return '${DateFormat.Hm().format(date)} ${DateFormat.yMd().format(date)}';
}

String formatShortDate(DateTime date) {
  return DateFormat.yMd().format(date);
}

extension FlipNotesFormat on DateTime {
  String toShortDateString() {
    return formatShortDate(this);
  }
}

extension ProperCase on String {
  String toProperCase() {
    final words = split(RegExp(r'[_]'));
    return words.map((w) => '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}').join(' ');
  }
}
