import 'package:intl/intl.dart';

class TextFormater {
  static String amount(double amount, {int? decimalDigits}) =>
      NumberFormat.decimalPatternDigits(
        locale: 'en_us',
        decimalDigits: decimalDigits,
      ).format(amount);
}
