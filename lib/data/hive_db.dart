import 'package:contacts_service/contacts_service.dart' as local;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/constants.dart';
import '../models/group.dart';
import 'hive_db_repository.dart';
import '/models/contact.dart';

class HiveDb implements HiveDbRepository {
  final HiveInterface hive;
  const HiveDb(this.hive);

  @override
  Future initializeBoxes() async {
    await hive.initFlutter();
    hive.registerAdapter<Contact>(ContactAdapter());
    // Hive.registerAdapter<ContactList>(ContactListAdapter());
    hive.registerAdapter<Group>(GroupAdapter());
    // await hive.openBox<bool>(permissionStatusBoxName);
    // await hive.openBox<Contact>(contactsBoxName);
    _openBox(permissionStatusBoxName);
    _openBox(contactsBoxName);
    // await Hive.openBox<ContactList>(contactListBoxName);
  }

  @override
  bool? getPermission() =>
      hive.box<bool>(permissionStatusBoxName).get(permissionStatusBoxName);

  @override
  Future<void> setPermission(bool value) async {
    try {
      // final permissionBox = await _openBox(permissionStatusBoxName);
      final permissionBox = await hive.openBox(permissionStatusBoxName);
      return permissionBox.put(permissionStatusBoxName, value);
    } catch (e) {
      throw Exception(e);
    }
  }

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
    final contactBox = hive.box<Contact>(contactsBoxName);
    await contactBox.putAll(result.asMap());

    // final contactBox = Hive.box<ContactList>(contactListBoxName);
    // await contactBox.put(contactsBoxName, ContactList(result));
  }

  @override
  List<Contact> getContacts() =>
      hive.box<Contact>(contactsBoxName).values.toList();

  @override
  Future<int> createContact(
      String name, String number, String email, Group group) {
    // final contactBox = Hive.box<ContactList>(contactListBoxName);
    // final contacts = [...getContacts()];
    // contacts.add(Contact(name: name, number: number, group: group));
    // contactBox.put(getContacts().length + 1, ContactList(contacts));
    final contactBox = hive.box<Contact>(contactsBoxName);
    return contactBox.add(Contact(name: name, number: number, group: group));
  }

  Future<Box> _openBox(String name) async {
    try {
      final box = await hive.openBox(name);
      return box;
    } catch (e) {
      throw Exception(e);
    }
  }
}
