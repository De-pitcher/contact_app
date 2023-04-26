import 'package:flutter/material.dart';

import '../models/contact.dart';
import '../utils/custom_search_delegate.dart';

class SearchTile extends StatelessWidget {
  final List<Contact> contacts;
  const SearchTile({
    super.key,
    required this.contacts,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: ListTile(
          onTap: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(contacts),
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          leading: const Icon(Icons.search),
          horizontalTitleGap: 0,
          title: Text(
            'Search by name or number',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
