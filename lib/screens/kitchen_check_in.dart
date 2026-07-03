import 'package:flutter/material.dart';

import '../widgets/chef_app_bar.dart';
import '../widgets/chef_button.dart';
import '../widgets/chef_empty_state.dart';
import '../widgets/chef_section_title.dart';

class KitchenCheckInScreen extends StatelessWidget {
  const KitchenCheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ChefAppBar(title: 'Kitchen Check-In'),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const ChefSectionTitle(
            title: 'Kitchen Check-In',
            subtitle: 'Help ChefOS keep your inventory accurate.',
            padding: EdgeInsets.zero,
          ),
          const SizedBox(height: 24),
          const ChefEmptyState(
            illustration: Icon(Icons.construction_outlined, size: 48),
            title: 'Coming Soon',
            description: 'This feature is currently being prepared for Phase 2. Soon you will be able to confirm your inventory with one tap.',
          ),
          const SizedBox(height: 16),
          ChefButton.primary(
            text: 'Back to Profile',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
