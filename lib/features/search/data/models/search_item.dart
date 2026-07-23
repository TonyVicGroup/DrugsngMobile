enum SearchType {
  all,
  product,
  diagnosticTest,
  wellnessPackage,
  testAndPackage;

  bool get isProduct => this == product;
  bool get isTest => this == diagnosticTest;
  bool get isPackage => this == wellnessPackage;
}

class SearchItem {
  final int id;
  final String name;
  final double price;
  final String subtitle;
  final double? rating;
  final String? image;
  final SearchType searchType;

  SearchItem({
    required this.id,
    required this.name,
    required this.price,
    required this.subtitle,
    required this.rating,
    required this.image,
    required this.searchType,
  });

  factory SearchItem.fromJson(Map json, SearchType searchType) {
    String name = json["name"];
    int id = json["id"];
    num price = json["price"];
    num? rating = json["rating"];
    if (searchType.isProduct) {
      List<String> images = List<String>.from(json["productImageUrls"]);
      String brandName = json["brandName"] ?? "";
      return SearchItem(
        id: id,
        name: name,
        price: price.toDouble(),
        subtitle: brandName,
        rating: rating?.toDouble(),
        image: images.isEmpty ? null : images.first,
        searchType: searchType,
      );
    } else if (searchType.isTest) {
      String description = json["description"];
      return SearchItem(
        id: id,
        name: name,
        price: price.toDouble(),
        subtitle: description,
        rating: rating?.toDouble(),
        image: null,
        searchType: searchType,
      );
    } else if (searchType.isPackage) {
      String? image = json["imageUrl"];
      return SearchItem(
        id: id,
        name: name,
        price: price.toDouble(),
        subtitle: "",
        rating: rating?.toDouble(),
        image: image,
        searchType: searchType,
      );
    } else {
      throw Exception("Invalid search type");
    }
  }
}
