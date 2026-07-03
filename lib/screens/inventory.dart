import 'package:flutter/material.dart';

import '../models/inventory_item.dart';
import '../models/inventory_store.dart';
import '../utils/recommendation_utils.dart';
import '../widgets/chef_app_bar.dart';
import '../widgets/chef_button.dart';
import '../widgets/chef_empty_state.dart';
import '../widgets/chef_inventory_card.dart';
import '../widgets/chef_section_title.dart';
import '../widgets/chef_text_field.dart';
import 'item_details.dart';
import 'profile.dart';
import 'setup.dart';

class InventoryScreen extends StatefulWidget {
  final String title;
  final String filter;

  const InventoryScreen({super.key, required this.title, this.filter = 'Inventory'});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final InventoryStore _store = InventoryStore.instance;
  late String _activeFilter;

  @override
  void initState() {
    super.initState();
    _activeFilter = widget.filter;
    _store.addListener(_handleStoreChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _store.removeListener(_handleStoreChanged);
    super.dispose();
  }

  void _handleStoreChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _deleteItem(InventoryItem item) {
    _store.removeItem(item);
  }

  void _editItem(InventoryItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ItemDetailsScreen(
          location: item.location,
          existingItem: item,
        ),
      ),
    );
  }

  void _startAddFlow() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SetupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final items = _store.items;
    final filteredItems = items.where((item) {
      final matchesLocation = _activeFilter == 'Inventory'
          ? true
          : _activeFilter == 'At Risk'
              ? item.expirationDate.difference(DateTime.now()).inDays <= 2
              : item.location == _activeFilter;
      final matchesQuery = query.isEmpty || item.productName.toLowerCase().contains(query);
      return matchesLocation && matchesQuery;
    }).toList();

    final titleText = _activeFilter == 'Inventory'
        ? 'Inventory'
        : _activeFilter == 'At Risk'
            ? 'Inventory'
            : _activeFilter;
    final subtitleText = _activeFilter == 'Inventory'
        ? 'Everything stored here, ready for quick decisions.'
        : _activeFilter == 'At Risk'
            ? '${filteredItems.length} Items'
            : '${filteredItems.length} Items';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ChefAppBar(
        title: _appBarTitle(_activeFilter),
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
        onPressed: _startAddFlow,
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 8),
          Text(
            titleText,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            subtitleText,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 24),
          const ChefSectionTitle(title: 'Inventory'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFilterChip(
                'All Items',
                'Inventory',
                _activeFilter,
                (filter) => setState(() => _activeFilter = filter),
              ),
              _buildFilterChip(
                'Refrigerator',
                'Refrigerator',
                _activeFilter,
                (filter) => setState(() => _activeFilter = filter),
              ),
              _buildFilterChip(
                'Freezer',
                'Freezer',
                _activeFilter,
                (filter) => setState(() => _activeFilter = filter),
              ),
              _buildFilterChip(
                'Pantry',
                'Pantry',
                _activeFilter,
                (filter) => setState(() => _activeFilter = filter),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ChefTextField(
            controller: _searchController,
            labelText: 'Search inventory',
            prefixIcon: const Icon(Icons.search),
          ),
          const SizedBox(height: 20),
          if (items.isEmpty)
            Column(
              children: [
                const ChefEmptyState(
                  illustration: Icon(Icons.inventory_2_outlined, size: 48),
                  title: 'No inventory yet.',
                  description: 'Start by adding your first ingredient.',
                ),
                const SizedBox(height: 16),
                ChefButton.primary(
                  text: 'Add First Item',
                  onPressed: _startAddFlow,
                ),
              ],
            )
          else if (filteredItems.isEmpty)
            const ChefEmptyState(
              illustration: Icon(Icons.search_off, size: 48),
              title: 'No items match your search yet.',
              description: 'Try a different product name or browse the full list.',
            )
          else
            ...filteredItems.map(
              (item) => Dismissible(
                key: ValueKey('${item.productName}-${item.expirationDate.toIso8601String()}'),
                background: Container(
                  color: Colors.red.shade100,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete_outline, color: Colors.red),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => _deleteItem(item),
                child: ChefInventoryCard(
                  product: item.productName,
                  quantity: '${item.quantity}',
                  expiration: RecommendationUtils.formatExpirationLabel(item.expirationDate),
                  location: item.location,
                  onTap: () {},
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () => _editItem(item),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => _deleteItem(item),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

String _appBarTitle(String filter) {
  switch (filter) {
    case 'Refrigerator':
      return '🧊 Refrigerator';
    case 'Freezer':
      return '❄️ Freezer';
    case 'Pantry':
      return '🥫 Pantry';
    default:
      return 'Inventory';
  }
}

Widget _buildFilterChip(
  String label,
  String filter,
  String activeFilter,
  ValueChanged<String> onSelected,
) {
  return ChoiceChip(
    label: Text(label),
    selected: activeFilter == filter,
    onSelected: (_) => onSelected(filter),
    selectedColor: Colors.black,
    backgroundColor: Colors.white,
    labelStyle: TextStyle(
      color: activeFilter == filter ? Colors.white : Colors.black,
    ),
  );
}