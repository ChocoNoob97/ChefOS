import 'package:flutter/material.dart';

import '../models/inventory_store.dart';
import '../utils/recommendation_utils.dart';
import '../widgets/chef_app_bar.dart';
import '../widgets/chef_empty_state.dart';
import '../widgets/chef_section_title.dart';
import '../widgets/chef_stat_card.dart';
import '../widgets/chef_inventory_card.dart';
import 'inventory.dart';
import 'item_details.dart';
import 'profile.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final InventoryStore _store = InventoryStore.instance;

  @override
  void initState() {
    super.initState();
    _store.addListener(_handleStoreChanged);
  }

  @override
  void dispose() {
    _store.removeListener(_handleStoreChanged);
    super.dispose();
  }

  void _handleStoreChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final inventoryItems = _store.items;

    final priorities = RecommendationUtils.getHighPriorityItems(inventoryItems);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ChefAppBar(
        title: 'ChefOS',
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ItemDetailsScreen(location: 'Refrigerator')),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 8),
          const Text(
            'My Kitchen',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Everything in one place, ready for smarter decisions.',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 24),
          const ChefSectionTitle(title: 'Inventory Summary'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildSummaryCard(
                context,
                icon: const Icon(Icons.inventory_2_outlined),
                title: 'Total Items',
                value: '${inventoryItems.length}',
                filter: 'Inventory',
              ),
              _buildSummaryCard(
                context,
                icon: const Icon(Icons.warning_amber_rounded),
                title: 'Expiring Soon',
                value: '${priorities.length}',
                filter: 'Inventory',
              ),
              _buildSummaryCard(
                context,
                icon: const Icon(Icons.lightbulb_outline),
                title: 'High Priority Recommendations',
                value: '${priorities.length}',
                filter: 'Inventory',
              ),
              _buildSummaryCard(
                context,
                icon: const Icon(Icons.restaurant_menu_outlined),
                title: 'Recommended Recipes',
                value: '0',
                filter: 'Inventory',
              ),
            ],
          ),
          const SizedBox(height: 24),
          const ChefSectionTitle(title: 'High Priority Recommendations'),
          const SizedBox(height: 12),
          if (priorities.isEmpty)
            const ChefEmptyState(
              illustration: Icon(Icons.check_circle_outline, size: 48),
              title: 'No high priority items.',
              description: 'Everything looks good.',
            )
          else
            ...priorities.asMap().entries.map((entry) {
              final item = entry.value;
              final reason = RecommendationUtils.buildRecommendationReason(
                item.expirationDate,
                index: entry.key,
              );
              return ChefInventoryCard(
                product: item.productName,
                quantity: '${item.quantity}',
                expiration: RecommendationUtils.formatExpirationLabel(item.expirationDate),
                location: item.location,
                reason: reason,
              );
            }),
          const SizedBox(height: 24),
          const ChefSectionTitle(title: 'Recommended Recipes'),
          const SizedBox(height: 12),
          const ChefEmptyState(
            illustration: Icon(Icons.restaurant_menu_outlined, size: 48),
            title: 'Recipe recommendations are coming soon.',
            description: 'ChefOS will help with recipe suggestions in a future update.',
          ),
        ],
      ),
    );
  }
}

Widget _buildSummaryCard(
  BuildContext context, {
    required Widget icon,
    required String title,
    required String value,
    required String filter,
  }) {
  return SizedBox(
    width: (MediaQuery.of(context).size.width - 48 - 12) / 2,
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => InventoryScreen(
              title: filter == 'Inventory' ? 'Inventory' : filter,
              filter: filter,
            ),
          ),
        );
      },
      child: ChefStatCard(
        icon: icon,
        title: title,
        value: value,
      ),
    ),
  );
}

