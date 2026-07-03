import 'package:flutter/material.dart';

import '../models/inventory_item.dart';
import '../widgets/chef_app_bar.dart';
import '../widgets/chef_button.dart';
import '../widgets/chef_card.dart';
import '../widgets/chef_form_page.dart';
import '../widgets/chef_text_field.dart';
import 'review_item.dart';

class ItemDetailsScreen extends StatefulWidget {
  final String location;
  final InventoryItem? existingItem;

  const ItemDetailsScreen({super.key, required this.location, this.existingItem});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  DateTime? _selectedDate;
  final DateTime _suggestedDate = DateTime.now().add(const Duration(days: 5));
  bool _recommendationApplied = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingItem != null) {
      _productNameController.text = widget.existingItem!.productName;
      _quantityController.text = widget.existingItem!.quantity.toString();
      _selectedDate = widget.existingItem!.expirationDate;
      _recommendationApplied = true;
    }
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? _suggestedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _recommendationApplied = false;
      });
    }
  }

  void _applyRecommendation() {
    if (_recommendationApplied) {
      return;
    }

    setState(() {
      _selectedDate = _suggestedDate;
      _recommendationApplied = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('ChefOS recommendation applied.')),
    );
  }

  void _continue() {
    final productName = _productNameController.text.trim();
    final quantity = int.tryParse(_quantityController.text.trim()) ?? 1;
    final normalizedName = InventoryItem.normalizeProductName(
      productName.isEmpty ? 'Untitled Item' : productName,
    );

    final item = InventoryItem(
      productName: normalizedName,
      quantity: quantity,
      expirationDate: _selectedDate ?? _suggestedDate,
      location: widget.location,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReviewItemScreen(item: item, existingItem: widget.existingItem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateLabel = _selectedDate == null
        ? 'Choose my own date'
        : '${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}';

    return ChefFormPage(
      appBar: const ChefAppBar(title: 'Item Details'),
      bottomAction: ChefButton.primary(
        text: 'Continue',
        onPressed: _continue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Add a fresh ingredient',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          ChefTextField(
            controller: _productNameController,
            labelText: 'Product Name',
          ),
          const SizedBox(height: 16),
          ChefTextField(
            controller: _quantityController,
            labelText: 'Quantity',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: _applyRecommendation,
            child: ChefCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _recommendationApplied
                        ? 'Recommendation Applied'
                        : 'ChefOS Recommendation',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${_suggestedDate.month}/${_suggestedDate.day}/${_suggestedDate.year}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tap to use the suggested expiration date.',
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ChefButton.secondary(
            text: dateLabel,
            leading: const Icon(Icons.calendar_today),
            onPressed: _selectDate,
          ),
        ],
      ),
    );
  }
}
