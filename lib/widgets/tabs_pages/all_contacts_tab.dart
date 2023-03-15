import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../constants/constants.dart';
import '../../models/contact_list.dart';
import '../contact_title.dart';


class AllContactsTab extends StatelessWidget {
  const AllContactsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<ContactList>(contactListBoxName).listenable(),
        builder: (ctx, box, _) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.builder(
              itemCount: box.values.first.contacts.length,
              itemBuilder: (_, index) {
                final currentContact = box.values.first.contacts[index];
                return ContactTile(
                  name: currentContact.name,
                  number: currentContact.number,
                );
              },
            ),
          );
        });
  }
}
