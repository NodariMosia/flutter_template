part of 'extensions.dart';

extension IterableExtension<K> on Iterable<K> {
  /// Puts [item] between iterable items and returns the resulting list
  List<T> intersperse<T>(T item) {
    final List<T> initialValue = <T>[];

    return fold(initialValue, (List<T> all, dynamic el) {
      if (all.isNotEmpty) all.add(item);
      all.add(el);
      return all;
    });
  }

  /// Copies original iterable and puts [item] at the start of the new list
  /// until new list length reaches [paddedLength].
  Iterable<K> padLeft(K item, int paddedLength) {
    final int addedItemsCount = paddedLength - length;

    return addedItemsCount <= 0 ? this : [...List.generate(addedItemsCount, (_) => item), ...this];
  }

  /// Copies original iterable and puts [item] at the end of the new list
  /// until new list length reaches [paddedLength].
  Iterable<K> padRight(K item, int paddedLength) {
    final int addedItemsCount = paddedLength - length;

    return addedItemsCount <= 0 ? this : [...this, ...List.generate(addedItemsCount, (_) => item)];
  }

  /// Returns new list with shuffled items.
  ///
  /// See also: [List.shuffle]
  List<K> toShuffled() {
    final List<K> copy = [...this];
    copy.shuffle();

    // copy.reversed;
    return copy;
  }

  /// Returns new list with sorted items.
  /// If [comparator] is null, then the default [Comparable] comparator is used.
  ///
  /// See also: [List.sort]
  List<K> toSorted(Comparator<K>? comparator) {
    final List<K> copy = [...this];
    copy.sort(comparator);
    return copy;
  }

  /// Returns a list of the results of applying the [toElement] function
  /// to each element of this iterable in iteration order.
  ///
  /// See also: [Iterable.map] and [Iterable.toList]
  List<OutputListItemType> mapToList<OutputListItemType>(
    OutputListItemType Function(K element) toElement,
  ) {
    final List<OutputListItemType> result = [];
    for (final K element in this) {
      result.add(toElement(element));
    }
    return result;
  }

  /// Returns a list of the results of applying the [toElement] function
  /// to each element of this iterable in iteration order.
  ///
  /// See also: [Iterable.map]
  List<OutputListItemType> mapWithIndexToList<OutputListItemType>(
    OutputListItemType Function(K element, int index) toElement,
  ) {
    final List<OutputListItemType> result = [];
    int index = 0;

    for (final K element in this) {
      result.add(toElement(element, index));
      index++;
    }

    return result;
  }

  /// Returns a list of the results of applying the [toElement] function
  /// to each element of this iterable in iteration order, interspersed with
  /// the [item] between each pair of elements.
  ///
  /// See also: [Iterable.map] and [intersperse]
  List<OutputListItemType> mapWithIntersperseToList<OutputListItemType>(
    OutputListItemType Function(K element) toElement,
    OutputListItemType item,
  ) {
    final List<OutputListItemType> result = [];
    int index = 0;

    for (final K element in this) {
      result.add(toElement(element));
      index++;

      if (index != length) {
        result.add(item);
      }
    }

    return result;
  }

  /// Returns a list containing only elements matching the [predicate] function.
  ///
  /// See also: [Iterable.where]
  List<K> whereWithIndex(bool Function(K element, int index) predicate) {
    final List<K> result = [];
    int index = 0;

    for (final K element in this) {
      if (predicate(element, index)) {
        result.add(element);
      }

      index++;
    }

    return result;
  }
}

extension MaybeIterableExtension<K> on Iterable<K>? {
  /// Returns `null` if it is `null` or an empty [Iterable]. Otherwise returns self.
  Iterable<K>? get nullIfEmpty => isFalsy ? null : this;

  /// Returns `true` if it is `null` or an empty [Iterable], `false` otherwise.
  bool get isFalsy => this == null || this!.isEmpty;

  /// Returns `false` if it is `null` or an  empty [Iterable], `true` otherwise.
  bool get isTruthy => this != null && this!.isNotEmpty;
}
