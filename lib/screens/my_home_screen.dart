import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart' as local;
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/constants.dart';
import '../models/contact.dart';
import '../models/contact_list.dart';
import '../models/group.dart';
import '../utils/custom_nav_bar.dart';
import '../widgets/contact_title.dart';
import '../widgets/search_tile.dart';
import '../widgets/tabs_pages/all_contacts_tab.dart';

class MyHomeScreen extends StatefulWidget {
  static const id = '/home';
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    // RecentTab(),
    // GroupTab(),
    AllContactsTab(),
    Text('Profile Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _initializeContacts(List<Contact> contacts) {
    final contactListBox = Hive.box<ContactList>(contactListBoxName);
    contactListBox.put('contact', ContactList(contacts));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Contact App'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: SearchTile(),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
