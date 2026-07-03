import 'package:flutter/material.dart';

class ChefButton extends StatelessWidget {
  final String text;
  final Widget? leading;
  final VoidCallback? onPressed;
  final bool outlined;
  final bool isEnabled;
  final EdgeInsetsGeometry? padding;
  final double? minHeight;

  const ChefButton({
    super.key,
    required this.text,
    this.leading,
    this.onPressed,
    this.padding,
    this.minHeight,
  })  : outlined = false,
        isEnabled = true;

  const ChefButton.primary({
    super.key,
    required this.text,
    this.leading,
    this.onPressed,
    this.padding,
    this.minHeight,
  })  : outlined = false,
        isEnabled = true;

  const ChefButton.secondary({
    super.key,
    required this.text,
    this.leading,
    this.onPressed,
    this.padding,
    this.minHeight,
  })  : outlined = true,
        isEnabled = true;

  const ChefButton.disabled({
    super.key,
    required this.text,
    this.leading,
    this.padding,
    this.minHeight,
  })  : outlined = false,
        onPressed = null,
        isEnabled = false;

  const ChefButton.outlined({
    super.key,
    required this.text,
    this.leading,
    this.onPressed,
    this.padding,
    this.minHeight,
  })  : outlined = true,
        isEnabled = true;

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = isEnabled ? onPressed : null;
    final label = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );

    final buttonStyle = outlined
        ? OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
            padding: padding ?? const EdgeInsets.symmetric(vertical: 18),
            side: const BorderSide(color: Colors.black12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          )
        : ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: padding ?? const EdgeInsets.symmetric(vertical: 18),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          );

    return SizedBox(
      width: double.infinity,
      child: outlined
          ? OutlinedButton(
              onPressed: effectiveOnPressed,
              style: buttonStyle,
              child: label,
            )
          : ElevatedButton(
              onPressed: effectiveOnPressed,
              style: buttonStyle,
              child: label,
            ),
    );
  }
}