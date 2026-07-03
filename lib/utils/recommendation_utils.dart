import '../models/inventory_item.dart';

class RecommendationUtils {
  static List<InventoryItem> getHighPriorityItems(List<InventoryItem> items) {
    final prioritizedItems = items
        .where((item) => item.expirationDate.difference(DateTime.now()).inDays <= 2)
        .toList()
      ..sort((a, b) => a.expirationDate.compareTo(b.expirationDate));

    return prioritizedItems;
  }

  static String formatExpirationLabel(DateTime expirationDate) {
    final difference = expirationDate.difference(DateTime.now()).inDays;
    if (difference <= 0) {
      return 'Expires today';
    }
    if (difference == 1) {
      return 'Expires tomorrow';
    }
    return 'Expires in $difference days';
  }

  static String buildRecommendationReason(DateTime expirationDate, {int index = 0}) {
    final difference = expirationDate.difference(DateTime.now()).inDays;
    if (difference <= 0) {
      return 'Expires Today';
    }
    if (difference == 1) {
      return 'Expires Tomorrow';
    }
    if (index == 0) {
      return 'Earliest Expiration';
    }
    return 'Expires in $difference Days';
  }
}
