class InventoryItem {
  static String normalizeProductName(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return 'Untitled Item';
    }

    final collapsed = trimmed.replaceAll(RegExp(r'\s+'), ' ');
    final normalizedWords = collapsed.split(' ').map((word) {
      if (word.isEmpty || word.contains(RegExp(r'\d'))) {
        return word;
      }

      final hasLetters = word.contains(RegExp(r'[A-Za-z]'));
      if (!hasLetters) {
        return word;
      }

      return word.substring(0, 1).toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');

    return normalizedWords;
  }

  final String productName;
  final int quantity;
  final DateTime expirationDate;
  final String location;

  InventoryItem({
    required String productName,
    required this.quantity,
    required this.expirationDate,
    required this.location,
  }) : productName = InventoryItem.normalizeProductName(productName);
}