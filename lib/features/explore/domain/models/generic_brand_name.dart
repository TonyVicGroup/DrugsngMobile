import 'package:equatable/equatable.dart';

class GenericBrandName extends Equatable {
  static const String _idKey = "id";
  static const String _nameKey = "name";
  static const String _descriptionKey = "description";

  final int id;
  final String name;
  final String description;

  const GenericBrandName({
    required this.id,
    required this.name,
    required this.description,
  });

  factory GenericBrandName.fromJson(Map json) => GenericBrandName(
        id: json[_idKey],
        name: json[_nameKey],
        description: json[_descriptionKey],
      );

  @override
  List<Object?> get props => [id, name, description];
}
