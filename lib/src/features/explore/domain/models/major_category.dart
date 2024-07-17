import 'package:equatable/equatable.dart';

class MajorCategoryData extends Equatable {
  static const String _drugCatKey = "drugCategories";
  static const String _healthCareCatKey = "healthCareCategories";

  final List<MajorCategory> drugCategory;
  final List<MajorCategory> healthCareCategory;

  const MajorCategoryData({
    required this.drugCategory,
    required this.healthCareCategory,
  });

  factory MajorCategoryData.fromJson(Map json) {
    return MajorCategoryData(
      drugCategory: List<Map>.from(json[_drugCatKey])
          .map<MajorCategory>((mc) => MajorCategory.fromJson(mc))
          .toList(),
      healthCareCategory: List<Map>.from(json[_healthCareCatKey])
          .map<MajorCategory>((mc) => MajorCategory.fromJson(mc))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [drugCategory, healthCareCategory];
}

class MajorCategory extends Equatable {
  static const String _idKey = "id";
  static const String _nameKey = "name";
  static const String _descriptionKey = "description";
  static const String _urlKey = "url";

  final int id;
  final String name;
  final String description;
  final String? url;

  const MajorCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
  });

  factory MajorCategory.fromJson(Map json) {
    return MajorCategory(
      id: json[_idKey],
      name: json[_nameKey],
      description: json[_descriptionKey],
      url: json[_urlKey],
    );
  }

  @override
  List<Object?> get props => [id, name, description, url];
}
