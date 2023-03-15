import 'package:flutter/material.dart';

import 'icon_card.dart';

class ContactDetailTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  const ContactDetailTile({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListTile(
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle!),
        trailing: trailing,
      ),
    );
  }
}
