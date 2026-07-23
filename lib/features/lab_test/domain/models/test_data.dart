import 'package:equatable/equatable.dart';

class TestData extends Equatable {
  static const String _idkey = "id";
  static const String _benefitkey = "name";
  static const String _descriptionkey = "description";

  final int id;
  final String name;
  final String description;

  const TestData({
    required this.id,
    required this.name,
    required this.description,
  });

  factory TestData.fromJson(Map json) => TestData(
        id: json[_idkey],
        name: json[_benefitkey],
        description: json[_descriptionkey],
      );

  @override
  List<Object?> get props => [id, name, description];
}
