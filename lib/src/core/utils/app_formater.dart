import 'package:intl/intl.dart';

class TextFormater {
  static final NumberFormat _numFormater = NumberFormat.decimalPatternDigits(
    locale: 'en_us',
    decimalDigits: 2,
  );

  static String amount(double amount) => _numFormater.format(amount);
}
