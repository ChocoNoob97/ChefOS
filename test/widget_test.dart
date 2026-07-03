import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chef_os/models/inventory_item.dart';
import 'package:chef_os/screens/dashboard.dart';
import 'package:chef_os/screens/inventory.dart';
import 'package:chef_os/screens/item_details.dart';

void main() {
  testWidgets('dashboard focuses on summary and recommendations', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: DashboardScreen()));

    expect(find.text('My Kitchen'), findsOneWidget);
    expect(find.text('Inventory Summary'), findsOneWidget);
    expect(find.text('High Priority Recommendations'), findsOneWidget);
    expect(find.text('Storage Areas'), findsNothing);
    expect(find.text('Pantry'), findsNothing);
  });

  testWidgets('item details does not ask for location again', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: ItemDetailsScreen(location: 'Refrigerator')),
    );

    expect(find.text('Location'), findsNothing);
  });

  testWidgets('inventory screen shows search and empty state', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: InventoryScreen(title: 'Refrigerator')),
    );

    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'mango');
    await tester.pump();

    expect(find.text('No items match your search yet.'), findsOneWidget);
  });

  test('normalizes product names before saving', () {
    final item = InventoryItem(
      productName: '  MiLK   and  green onions  ',
      quantity: 1,
      expirationDate: DateTime(2030, 1, 1),
      location: 'Refrigerator',
    );

    expect(item.productName, 'Milk And Green Onions');
  });
}
