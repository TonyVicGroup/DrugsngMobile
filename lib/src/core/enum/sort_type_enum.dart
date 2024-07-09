enum SortTypeEnum {
  newArrival,
  bestSeller,
  mostRated,
  discounted;

  String get displayName {
    switch (this) {
      case newArrival:
        return "New Arrival";
      case bestSeller:
        return "Best Seller";
      case mostRated:
        return "Most Rated";
      case discounted:
        return "Discounted";
    }
  }
}
