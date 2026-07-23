class SubCategory {
  static const String _idKey = "id";
  static const String _nameKey = "name";
  static const String _descriptionKey = "description";
  static const String _categoryIdKey = "categoryId";
  static const String _categoryNameKey = "categoryName";

  final int id;
  final String name;
  final String description;
  final int categoryId;
  final String categoryName;

  SubCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.categoryName,
  });

  factory SubCategory.fromJson(Map json) => SubCategory(
        id: json[_idKey],
        name: json[_nameKey],
        description: json[_descriptionKey],
        categoryId: json[_categoryIdKey],
        categoryName: json[_categoryNameKey],
      );
}
