import 'package:contact_app/screens/add_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/constants.dart';
import '../data/hive_db.dart';
import '../models/contact_list.dart';
import '../widgets/search_tile.dart';
import '../widgets/contact_list_widget.dart';

class MyHomeScreen extends StatefulWidget {
  static const id = '/home';
  const MyHomeScreen({super.key});

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
          bottom: PreferredSize(
            preferredSize:
                Size.fromHeight(orientation == Orientation.landscape ? 10 : 70),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SearchTile(contacts: HiveDb(Hive).getContacts()),
            ),
          ),
        ),
        body: const ContactListWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AddContact()),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
