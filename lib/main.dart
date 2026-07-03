import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/home.dart';

void main() {
  runApp(const ChefOS());
}

class ChefOS extends StatelessWidget {
  const ChefOS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'ChefOS',

      theme: AppTheme.lightTheme,

      home: const HomeScreen(),
    );
  }
}