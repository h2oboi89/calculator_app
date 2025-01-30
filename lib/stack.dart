class Stack<E> {
  Stack() : _storage = <E>[];
  final List<E> _storage;

  void push(E element) {
    _storage.add(element);
  }

  E pop() {
    if (isEmpty) {
      throw RangeError('Cannot pop from an empty stack');
    }

    return _storage.removeLast();
  }

  E peek() {
    if (isEmpty) {
      throw RangeError('Cannot peek an empty stack');
    }
    
    return _storage.last;
  }

  void clear() {
    _storage.clear();
  }

  bool get isEmpty => _storage.isEmpty;

  bool get isNotEmpty => _storage.isNotEmpty;

  @override
  String toString() {
    return _storage.join(' ');
  }
}
