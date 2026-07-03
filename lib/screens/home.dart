import 'package:flutter/material.dart';

import '../widgets/chef_app_bar.dart';
import '../widgets/chef_button.dart';
import 'setup.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ChefAppBar(title: 'ChefOS'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Every Ingredient Matters.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ChefButton.primary(
              text: 'Get Started',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SetupScreen(),
                  ),
                );
              },
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            ),
          ],
        ),
      ),
    );
  }
}
