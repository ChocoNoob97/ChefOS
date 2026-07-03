import 'package:flutter/material.dart';

class ChefInventoryCard extends StatelessWidget {
  final String product;
  final String quantity;
  final String expiration;
  final String location;
  final String? reason;
  final VoidCallback? onTap;
  final Widget? trailing;

  const ChefInventoryCard({
    super.key,
    required this.product,
    required this.quantity,
    required this.expiration,
    required this.location,
    this.reason,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(product),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$quantity • $expiration'),
            if (reason != null && reason!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                'Reason: $reason',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ],
        ),
        trailing: trailing ?? Text(location),
        onTap: onTap,
      ),
    );
  }
}
