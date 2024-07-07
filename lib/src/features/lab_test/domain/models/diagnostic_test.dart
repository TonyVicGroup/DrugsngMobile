import 'package:equatable/equatable.dart';

class DiagnosticTest extends Equatable {
  static const String _iconKey = "icon";
  static const String _titleKey = "title";
  static const String _textKey = "text";
  static const String _priceKey = "price";

  final String icon;
  final String title;
  final String text;
  final double price;

  const DiagnosticTest({
    required this.icon,
    required this.title,
    required this.text,
    required this.price,
  });

  factory DiagnosticTest.fromJson(Map json) {
    return DiagnosticTest(
      icon: json[_iconKey],
      title: json[_titleKey],
      text: json[_textKey],
      price: double.parse("${json[_priceKey]}"),
    );
  }

  @override
  List<Object?> get props => [price, icon, title, text];
}
