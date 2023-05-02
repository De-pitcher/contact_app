import 'package:flutter/material.dart';

import '../models/contact.dart';
import '../widgets/contact_tile.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<Contact> searchItems;

  CustomSearchDelegate(this.searchItems);

// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<Contact> matchQuery = [];
    for (var item in searchItems) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var contact = matchQuery[index];
        return ContactTile(
          id: contact.id,
          name: contact.name,
          number: contact.number,
          group: contact.group,
          tag: contact.getSuspensionTag(),
        );
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<Contact> matchQuery = [];
    for (var fruit in searchItems) {
      if (fruit.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var contact = matchQuery[index];
        return ContactTile(
          id: contact.id,
          name: contact.name,
          number: contact.number,
          group: contact.group,
          tag: contact.getSuspensionTag(),
        );
      },
    );
  }
}
