import 'package:equatable/equatable.dart';

class ConsultService extends Equatable {
  static const String _idKey = "id";
  static const String _nameKey = "name";
  static const String _specialistKey = "specialist";
  static const String _imageUrlKey = "imageUrl";
  static const String _descriptionKey = "description";

  final int id;
  final String name;
  final String specialist;
  final String imageUrl;
  final String description;

  const ConsultService({
    required this.id,
    required this.name,
    required this.specialist,
    required this.imageUrl,
    required this.description,
  });

  factory ConsultService.fromJson(Map json) => ConsultService(
        id: json[_idKey],
        name: json[_nameKey],
        specialist: json[_specialistKey],
        imageUrl: json[_imageUrlKey],
        description: json[_descriptionKey],
      );

  @override
  List<Object?> get props => [id, name, specialist, imageUrl, description];
}
