import 'package:flutter/material.dart';

import 'chef_card.dart';

class ChefInfoTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  const ChefInfoTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.padding = const EdgeInsets.only(bottom: 12),
    this.titleStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ChefCard(
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: leading,
          title: Text(
            title,
            style: titleStyle,
          ),
          subtitle: subtitle == null ? null : Text(subtitle!, style: subtitleStyle),
          trailing: trailing,
          onTap: onTap,
        ),
      ),
    );
  }
}
