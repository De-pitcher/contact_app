import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/constants.dart';
import '../models/contact_list.dart';
import '../widgets/search_tile.dart';
import '../widgets/all_contacts_widget.dart';

class MyHomeScreen extends StatefulWidget {
  static const id = '/home';
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Contact App'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: SearchTile(
              contacts: Hive.box<ContactList>(contactListBoxName)
                  .values
                  .first
                  .contacts),
        ),
      ),
      body: const AllContactsTab(),
    );
  }
}
