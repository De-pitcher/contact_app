import 'package:contacts_service/contacts_service.dart' as local;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/constants.dart';
import '../models/group.dart';
import 'hive_db_repository.dart';
import '/models/contact.dart';

class HiveDb implements HiveDbRepository {
  @override
  Future initializeBoxes() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Contact>(ContactAdapter());
    // Hive.registerAdapter<ContactList>(ContactListAdapter());
    Hive.registerAdapter<Group>(GroupAdapter());
    await Hive.openBox<bool>(permissionStatusBoxName);
    await Hive.openBox<Contact>(contactsBoxName);
    // await Hive.openBox<ContactList>(contactListBoxName);
  }

  @override
  bool? getPermission() =>
      Hive.box<bool>(permissionStatusBoxName).get(permissionStatusBoxName);

  @override
  void setPermission(bool value) => Hive.box<bool>(permissionStatusBoxName)
      .put(permissionStatusBoxName, value);

  @override
  Future initializeContact(List<local.Contact> contacts) async {
    List<Contact> result = [];

    contacts.map((value) {
      final name = value.givenName ?? value.displayName ?? 'Unknown';
      final number = value.phones == null || value.phones!.isEmpty
          ? ''
          : value.phones!.first.value ?? '';
      return Contact(
        name: name,
        number: number.startsWith(name.characters.first) ? '' : number,
        group: Group.non,
      );
    }).toList();
    final contactBox = Hive.box<Contact>(contactsBoxName);
    await contactBox.putAll(result.asMap());

    // final contactBox = Hive.box<ContactList>(contactListBoxName);
    // await contactBox.put(contactsBoxName, ContactList(result));
  }

  @override
  List<Contact> getContacts() =>
      Hive.box<Contact>(contactsBoxName).values.toList();

  @override
  Future<int> createContact(String name, String number, String email, Group group) {
    // final contactBox = Hive.box<ContactList>(contactListBoxName);
    // final contacts = [...getContacts()];
    // contacts.add(Contact(name: name, number: number, group: group));
    // contactBox.put(getContacts().length + 1, ContactList(contacts));
    final contactBox = Hive.box<Contact>(contactsBoxName);
    return contactBox.add(Contact(name: name, number: number, group: group));
   
  }
}
