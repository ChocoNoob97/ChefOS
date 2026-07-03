import 'package:flutter/material.dart';

class ChefFormPage extends StatelessWidget {
  final Widget child;
  final Widget bottomAction;
  final Color backgroundColor;
  final PreferredSizeWidget? appBar;

  const ChefFormPage({
    super.key,
    required this.child,
    required this.bottomAction,
    this.backgroundColor = Colors.white,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: child,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                24,
                16,
                24,
                24,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFE5E5E5),
                  ),
                ),
              ),
              child: bottomAction,
            ),
          ],
        ),
      ),
    );
  }
}