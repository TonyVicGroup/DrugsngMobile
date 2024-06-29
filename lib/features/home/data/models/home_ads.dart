import 'package:equatable/equatable.dart';

class HomeAds extends Equatable {
  static const String _imageUrlKey = "imageUrl";
  static const String _titleKey = "title";
  static const String _subtitleKey = "subtitle";

  final String imageUrl;
  final String title;
  final String subtitle;

  const HomeAds({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  factory HomeAds.fromJson(Map json) {
    return HomeAds(
      imageUrl: json[_imageUrlKey],
      title: json[_titleKey],
      subtitle: json[_subtitleKey],
    );
  }

  @override
  List<Object?> get props => [imageUrl, title, subtitle];
}
