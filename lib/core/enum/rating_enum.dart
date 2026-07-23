enum RatingEnum {
  all,
  one,
  two,
  three,
  four,
  five;

  int? get starCount {
    switch (this) {
      case all:
        return null;
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

  // String get displayName {
  //   switch (this) {
  //     case all:
  //       return "All star";
  //     case five:
  //       return "Five star";
  //     case four:
  //       return "Four star";
  //     case three:
  //       return "Three star";
  //     case two:
  //       return "Two star";
  //     case one:
  //       return "One star";
  //   }
  // }

  factory RatingEnum.fromInt(int? star) {
    switch (star) {
      case 1:
        return one;
      case 2:
        return two;
      case 3:
        return three;
      case 4:
        return four;
      case 5:
        return five;
      default:
        return all;
    }
  }
}
