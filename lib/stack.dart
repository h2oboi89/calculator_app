class Stack<E> {
  Stack() : _storage = <E>[];
  final List<E> _storage;

  void push(E element) {
    _storage.add(element);
  }

  E pop() {
    return _storage.removeLast();
  }

  E peek() {
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
