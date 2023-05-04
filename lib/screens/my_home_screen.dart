import 'package:contact_app/screens/add_contact_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/constants.dart';
import '../data/hive_db.dart';
import '../models/contact.dart';
import '../widgets/search_tile.dart';
import '../widgets/contact_list_widget.dart';

class MyHomeScreen extends StatefulWidget {
  final ValueListenable<Box<Contact>>? contactListenable;
  const MyHomeScreen({super.key, this.contactListenable});

  static const id = '/home';

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: orientation == Orientation.landscape
              ? null
              : Text(
                  'Contacts',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          actions: [
            ValueListenableBuilder(
              valueListenable:
                  HiveDb(Hive).hive.box<bool>(darkModeBoxName).listenable(),
              builder: (_, box, __) {
                var darkMode = box.get(darkModeBoxName, defaultValue: false);
                return IconButton(
                  icon: Icon(
                    darkMode!
                        ? Icons.dark_mode_rounded
                        : Icons.dark_mode_outlined,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  onPressed: () {
                    box.put(darkModeBoxName, !darkMode);
                  },
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable:
                  HiveDb(Hive).hive.box<bool>(showGroupBoxName).listenable(),
              builder: (_, box, __) {
                var showGroup = box.get(showGroupBoxName, defaultValue: false);
                return IconButton(
                  onPressed: () {
                    box.put(showGroupBoxName, !showGroup);
                  },
                  icon: Icon(
                    showGroup! ? Icons.group : Icons.group_outlined,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                );
              },
            )
          ],
          bottom: PreferredSize(
            preferredSize:
                Size.fromHeight(orientation == Orientation.landscape ? 10 : 70),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SearchTile(contacts: HiveDb(Hive).getContacts()),
            ),
          ),
        ),
        body: ContactListWidget(
          contactListenable: widget.contactListenable ??
              HiveDb(Hive).hive.box<Contact>(contactsBoxName).listenable(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddContact.id);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
