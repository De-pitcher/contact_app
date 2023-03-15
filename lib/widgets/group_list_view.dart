import 'package:flutter/material.dart';

import '../models/contact.dart';
import './contact_title.dart';

class GroupListView extends StatelessWidget {
  final List<Contact> groupContacts;
  final String groupName;
  final Color color;
  const GroupListView({
    super.key,
    required this.groupName,
    required this.color,
    required this.groupContacts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            groupName,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SizedBox(
          height: 75.0 * groupContacts.length,
          child: Column(
            children: groupContacts
                .map(
                  (item) => ContactTile(
                    name: item.name,
                    number: item.number.toString(),
                    // imageUrl: item.imageUrl,
                    group: groupName,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
