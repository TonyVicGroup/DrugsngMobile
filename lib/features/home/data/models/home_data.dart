import 'package:drugs_ng/core/data/models/product.dart';
import 'package:drugs_ng/features/home/data/models/home_ads.dart';
import 'package:equatable/equatable.dart';

class HomeData extends Equatable {
  static const String _newArrivalsKey = "new_arrivals";
  static const String _bestSellersKey = "best_sellers";
  static const String _homeAdsKey = "ads";

  final List<Product> newArrivals;
  final List<Product> bestSellers;
  final List<HomeAds> homeAds;

  const HomeData({
    required this.newArrivals,
    required this.bestSellers,
    required this.homeAds,
  });

  factory HomeData.fromJson(Map json) {
    List<Product> arrivals = List<Map>.from(json[_newArrivalsKey])
        .map<Product>((e) => Product.fromJson(e))
        .toList();
    List<Product> sellers = List<Map>.from(json[_bestSellersKey])
        .map<Product>((e) => Product.fromJson(e))
        .toList();
    List<HomeAds> ads = List<Map>.from(json[_homeAdsKey])
        .map<HomeAds>((e) => HomeAds.fromJson(e))
        .toList();
    return HomeData(newArrivals: arrivals, bestSellers: sellers, homeAds: ads);
  }

  @override
  List<Object?> get props => [newArrivals, bestSellers, homeAds];
}
