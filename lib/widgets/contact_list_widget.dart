import 'package:contact_app/models/group.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/constants.dart';
import '../data/hive_db.dart';
import '../models/contact.dart';
import 'alphabetic_scroll_page.dart';
import 'empty_widget.dart';
import 'group_list_widget.dart';

class ContactListWidget extends StatefulWidget {
  final ValueListenable<Box<Contact>> contactListenable;
  const ContactListWidget({
    super.key,
    required this.contactListenable,
  });

  @override
  State<ContactListWidget> createState() => _ContactListWidgetState();
}

class _ContactListWidgetState extends State<ContactListWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Contact>>(
      valueListenable: widget.contactListenable,
      builder: (_, box, __) => box.values.isEmpty
          ? const EmptyWidget()
          : ValueListenableBuilder(
              valueListenable:
                  HiveDb(Hive).hive.box<bool>(showGroupBoxName).listenable(),
              builder: (_, showGroupbox, __) {
                var showGroup =
                    showGroupbox.get(showGroupBoxName, defaultValue: false);
                return showGroup!
                    ? Scaffold(
                        body: ListView.builder(
                          itemBuilder: (_, index) {
                            var groupContact = box.values
                                .where((e) =>
                                    e.group == groupString.keys.toList()[index])
                                .toList();
                            return GroupListWidget(
                              contacts: groupContact,
                              groupName: groupString.values.toList()[index],
                            );
                          },
                          itemCount: groupString.length,
                        ),
                      )
                    : AlphabeticScrollPage(
                        contacts: box.values.toList(),
                      );
              },
            ),
    );
  }
}
