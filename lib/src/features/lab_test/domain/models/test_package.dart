import 'package:equatable/equatable.dart';

class TestPackage extends Equatable {
  static const String _discountKey = "discount";
  static const String _titleKey = "title";
  static const String _textKey = "text";
  static const String _imageKey = "image";

  final int? discount;
  final String title;
  final String text;
  final String image;

  const TestPackage({
    required this.discount,
    required this.title,
    required this.text,
    required this.image,
  });

  factory TestPackage.fromJson(Map json) {
    return TestPackage(
      discount: json[_discountKey],
      title: json[_titleKey],
      text: json[_textKey],
      image: json[_imageKey],
    );
  }

  @override
  List<Object?> get props => [discount, title, text, image];
}
