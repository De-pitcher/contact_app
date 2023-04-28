import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/constants.dart';
import '../data/hive_db.dart';
import '../models/contact.dart';
import '../models/contact_list.dart';
import 'alphabetic_scroll_page.dart';
import 'empty_widget.dart';

class ContactListWidget extends StatefulWidget {
  const ContactListWidget({
    super.key,
  });

  @override
  State<ContactListWidget> createState() => _ContactListWidgetState();
}

class _ContactListWidgetState extends State<ContactListWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Contact>>(
      valueListenable:
          HiveDb(Hive).hive.box<Contact>(contactsBoxName).listenable(),
      builder: (_, box, __) => box.values.isEmpty
          ? const EmptyWidget()
          : AlphabeticScrollPage(
              contacts: box.values.toList(),
            ),
    );
  }
}
