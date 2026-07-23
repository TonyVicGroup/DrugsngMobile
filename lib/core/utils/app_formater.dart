import 'package:intl/intl.dart';

class TextFormater {
  static String amount(double amount, {int? decimalDigits}) =>
      NumberFormat.decimalPatternDigits(
        locale: 'en_NG',
        decimalDigits: decimalDigits,
      ).format(amount);
  static String currency(double amount, {int decimalDigits = 0}) =>
      NumberFormat.simpleCurrency(
        decimalDigits: decimalDigits,
        locale: 'en_NG',
        name: 'NGN',
      ).format(amount);
}
