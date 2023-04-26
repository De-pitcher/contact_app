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
        elevation: 0,
        color: Theme.of(context).appBarTheme.foregroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          // tileColor: Theme.of(context).appBarTheme.foregroundColor,
          onTap: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(contacts),
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          leading: Icon(
            Icons.search,
            color: Theme.of(context).appBarTheme.backgroundColor,
          ),
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
