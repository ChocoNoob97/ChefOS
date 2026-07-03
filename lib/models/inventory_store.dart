import 'package:flutter/foundation.dart';

import 'inventory_item.dart';

class InventoryStore extends ChangeNotifier {
  InventoryStore._();

  static final InventoryStore instance = InventoryStore._();

  final List<InventoryItem> _items = [];

  List<InventoryItem> get items => List.unmodifiable(_items);

  void addItem(InventoryItem item) {
    final duplicate = _items.any(
      (existing) =>
          existing.location.toLowerCase() == item.location.toLowerCase() &&
          existing.productName.toLowerCase() == item.productName.toLowerCase(),
    );

    if (duplicate) {
      return;
    }

    _items.add(item);
    notifyListeners();
  }

  bool removeItem(InventoryItem item) {
    final removed = _items.remove(item);
    if (removed) {
      notifyListeners();
    }
    return removed;
  }

  void clear() {
    if (_items.isEmpty) {
      return;
    }

    _items.clear();
    notifyListeners();
  }
}
