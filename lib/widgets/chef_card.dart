import 'package:flutter/material.dart';

class ChefCard extends StatelessWidget {
  final Widget child;

  const ChefCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}