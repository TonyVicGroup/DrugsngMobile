extension ListExtension<T> on List<T> {
  /// Searches for an item in the list
  /// If the item is not found, it returns null.
  T? searchOrNull(bool Function(T element) predicate) {
    for (var element in this) {
      if (predicate(element)) {
        return element;
      }
    }
    return null;
  }
}
