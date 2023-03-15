import 'package:flutter/material.dart';

import '../utils/custom_search_delegate.dart';

class SearchTile extends StatelessWidget {
  const SearchTile({
    super.key,
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
              delegate: CustomSearchDelegate(),
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          leading: const Icon(Icons.search),
          horizontalTitleGap: 0,
          title: const Text('Search by name or number'),
        ),
      ),
    );
  }
}
