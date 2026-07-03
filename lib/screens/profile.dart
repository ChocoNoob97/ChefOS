import 'package:flutter/material.dart';

import '../models/inventory_store.dart';
import '../widgets/chef_app_bar.dart';
import '../widgets/chef_button.dart';
import '../widgets/chef_section_title.dart';
import 'kitchen_check_in.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final InventoryStore _store = InventoryStore.instance;

  Future<void> _confirmClear() async {
    final shouldClear = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Inventory?'),
        content: const Text('This will remove every current item from your inventory.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ChefButton.primary(
            text: 'Clear Inventory',
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (shouldClear == true) {
      _store.clear();
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ChefAppBar(title: 'Profile'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ChefSectionTitle(
              title: 'Inventory Actions',
              subtitle: 'Keep your list accurate with a single tap.',
              padding: EdgeInsets.zero,
            ),
            const SizedBox(height: 24),
            ChefButton.secondary(
              text: 'Kitchen Check-In',
              leading: const Icon(Icons.fact_check_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const KitchenCheckInScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            ChefButton.secondary(
              text: 'Clear Inventory',
              leading: const Icon(Icons.delete_outline),
              onPressed: _confirmClear,
            ),
          ],
        ),
      ),
    );
  }
}
