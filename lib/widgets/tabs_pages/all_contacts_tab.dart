import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../constants/constants.dart';
import '../../models/contact.dart';
import '../../models/contact_list.dart';
import '../alphabetic_scroll_page.dart';
import '../contact_tile.dart';
import '../empty_widget.dart';

class AllContactsTab extends StatefulWidget {
  const AllContactsTab({
    super.key,
  });

  @override
  State<AllContactsTab> createState() => _AllContactsTabState();
}

class _AllContactsTabState extends State<AllContactsTab> {
  List<Contact> contactList = [];
  List<String> strList = [];
  List<Widget> favouriteList = [];
  List<Widget> normalList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    contactList.addAll(
        Hive.box<ContactList>(contactListBoxName).values.first.contacts);
    // print(contactList.length);
    contactList
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    filterList();
    searchController.addListener(() {
      filterList();
    });
    super.initState();
  }

  filterList() {
    List<Contact> contacts = [];
    contacts.addAll(contactList);
    if (searchController.text.isNotEmpty) {
      contacts.retainWhere((user) => user.name
          .toLowerCase()
          .contains(searchController.text.toLowerCase()));
    }
    for (var contact in contacts) {
      normalList.add(
        ContactTile(
          name: contact.name,
          number: contact.name,
          tag: contact.getSuspensionTag(),
        ),
      );
      strList.add(contact.name);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<ContactList>(contactListBoxName).listenable(),
      builder: (_, box, __) => box.values.isEmpty
          ? const EmptyWidget()
          : AlphabeticScrollPage(
              contacts: box.values.first.contacts,
            ),
    );
  }
}
