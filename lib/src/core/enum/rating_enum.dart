enum RatingEnum {
  all,
  five,
  four,
  three,
  two,
  one;

  int get starCount {
    switch (this) {
      case all:
        return 0;
      case five:
        return 5;
      case four:
        return 4;
      case three:
        return 3;
      case two:
        return 2;
      case one:
        return 1;
    }
  }

  String get displayName {
    switch (this) {
      case all:
        return "All star";
      case five:
        return "Five star";
      case four:
        return "Four star";
      case three:
        return "Three star";
      case two:
        return "Two star";
      case one:
        return "One star";
    }
  }
}
