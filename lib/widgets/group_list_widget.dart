import 'package:flutter/material.dart';

import '../models/contact.dart';
import 'contact_tile.dart';

class GroupListWidget extends StatelessWidget {
  final List<Contact> contacts;
  final String groupName;
  const GroupListWidget({
    super.key,
    required this.contacts,
    required this.groupName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            groupName,
            style: Theme.of(context).textTheme.titleMedium!,
          ),
        ),
        SizedBox(
          height: 75.0 * contacts.length,
          child: Column(
            children: contacts
                .map(
                  (item) => ContactTile(
                    name: item.name,
                    number: item.number,
                    group: item.group,
                    email: item.email,
                    id: item.id,
                    tag: item.getSuspensionTag(),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
