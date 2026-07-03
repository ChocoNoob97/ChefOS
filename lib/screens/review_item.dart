import 'package:flutter/material.dart';

import '../models/inventory_item.dart';
import '../models/inventory_store.dart';
import '../widgets/chef_app_bar.dart';
import '../widgets/chef_button.dart';
import '../widgets/chef_form_page.dart';
import '../widgets/chef_info_tile.dart';
import '../widgets/chef_section_title.dart';
import 'dashboard.dart';

class ReviewItemScreen extends StatelessWidget {
  final InventoryItem item;
  final InventoryItem? existingItem;

  const ReviewItemScreen({super.key, required this.item, this.existingItem});

  @override
  Widget build(BuildContext context) {
    final reviewItems = [
      _ReviewRow(
        icon: Icons.shopping_bag_outlined,
        title: 'Product Name',
        value: item.productName,
      ),
      _ReviewRow(
        icon: Icons.inventory_2_outlined,
        title: 'Quantity',
        value: '${item.quantity}',
      ),
      _ReviewRow(
        icon: Icons.calendar_today,
        title: 'Expiration Date',
        value: '${item.expirationDate.month}/${item.expirationDate.day}/${item.expirationDate.year}',
      ),
      _ReviewRow(
        icon: Icons.kitchen_outlined,
        title: 'Location',
        value: item.location,
      ),
    ];

    return ChefFormPage(
      appBar: const ChefAppBar(title: 'Review Item'),
      bottomAction: ChefButton.primary(
        text: 'Save Item',
        leading: const Icon(Icons.check),
        onPressed: () {
          if (existingItem != null) {
            InventoryStore.instance.removeItem(existingItem!);
          }
          InventoryStore.instance.addItem(item);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const DashboardScreen()),
            (route) => false,
          );
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ChefSectionTitle(
            title: 'Double-check your entry',
            subtitle: 'Everything you need to keep this ingredient organized.',
            padding: EdgeInsets.zero,
          ),
          const SizedBox(height: 24),
          ...reviewItems.map(
            (row) => ChefInfoTile(
              leading: Icon(row.icon),
              title: row.title,
              subtitle: row.value,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewRow {
  final IconData icon;
  final String title;
  final String value;

  const _ReviewRow({
    required this.icon,
    required this.title,
    required this.value,
  });
}