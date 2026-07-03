import 'package:flutter/material.dart';

import '../widgets/chef_app_bar.dart';
import '../widgets/chef_button.dart';
import '../widgets/chef_section_title.dart';
import 'item_details.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  static const List<_StorageOption> _storageOptions = [
    _StorageOption(emoji: '🧊', title: 'Refrigerator'),
    _StorageOption(emoji: '❄️', title: 'Freezer'),
    _StorageOption(emoji: '🥫', title: 'Pantry'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ChefAppBar(title: 'ChefOS'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Let's build your kitchen.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const ChefSectionTitle(
                title: 'Where would you like to start?',
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: 40),
              ..._storageOptions.map(
                (option) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ChefButton.secondary(
                    text: option.title,
                    leading: Text(
                      option.emoji,
                      style: const TextStyle(fontSize: 24),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemDetailsScreen(
                            location: option.title,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StorageOption {
  final String emoji;
  final String title;

  const _StorageOption({required this.emoji, required this.title});
}