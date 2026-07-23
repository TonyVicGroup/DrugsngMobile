extension CapExtension on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get capitalizeFirstofEach =>
      split(" ").map((str) => str.capitalize).join(" ");
}
