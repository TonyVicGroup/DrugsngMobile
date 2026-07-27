extension CapExtension on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get capitalizeFirstofEach =>
      split(" ").map((str) => str.capitalize).join(" ");

  String get hideNumber =>
      '${substring(0, 3)}${''.padLeft(length - 5, '*')}${substring(length - 2)}';

  String get hideEmail {
    final splitt = split('@');
    if (splitt.length < 2) return '';

    return '${splitt.first.substring(0, 3)}*** ${splitt.last}';
  }
}
