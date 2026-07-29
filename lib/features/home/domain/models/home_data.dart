import 'package:drugs_ng/features/product/domain/models/product.dart';
import 'package:equatable/equatable.dart';

class HomeData extends Equatable {
  static const String _newArrivalsKey = "newArrivals";
  static const String _bestSellersKey = "bestSellers";

  final List<Product> newArrivals;
  final List<Product> bestSellers;

  const HomeData({required this.newArrivals, required this.bestSellers});

  factory HomeData.fromJson(Map json) {
    List<Product> arrivals =
        List<Map>.from(
          json[_newArrivalsKey] ?? [],
        ).map<Product>((e) => Product.fromJson(e)).toList();
    List<Product> sellers =
        List<Map>.from(
          json[_bestSellersKey] ?? [],
        ).map<Product>((e) => Product.fromJson(e)).toList();

    return HomeData(newArrivals: arrivals, bestSellers: sellers);
  }

  @override
  List<Object?> get props => [newArrivals, bestSellers];
}
