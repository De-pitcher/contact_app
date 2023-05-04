import 'dart:developer';

import 'package:contacts_service/contacts_service.dart' as local;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../constants/constants.dart';
import '../models/group.dart';
import 'hive_db_repository.dart';
import '/models/contact.dart';

class HiveDb implements HiveDbRepository {
  const HiveDb(this.hive);

  final HiveInterface hive;

  @override
  Future initializeDb() async {
    await hive.initFlutter();
    await _openBox<bool>(darkModeBoxName);
    hive.registerAdapter<Contact>(ContactAdapter());
    hive.registerAdapter<Group>(GroupAdapter());
  }

  Future<Box<E>> _openBox<E>(String name) async {
    try {
      final box = await hive.openBox<E>(name);
      return box;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> setPermission(bool value) async {
    try {
      final permissionBox = await _openBox(permissionStatusBoxName);
      return permissionBox.put(permissionStatusBoxName, value);
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  bool? getPermission([String? name]) {
    if (hive.isBoxOpen(name ?? permissionStatusBoxName)) {
      final permissionBox = hive.box<bool>(name ?? permissionStatusBoxName);
      return permissionBox.get(name ?? permissionStatusBoxName);
    }
    return null;
  }

  @override
  Future<void> initializeContact(List<Contact> contacts) async {
    try {
      final contactBox = await _openBox<Contact>(contactsBoxName);
      return contactBox.putAll(contacts.asMap());
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  List<Contact> getContacts([String? name]) {
    if (hive.isBoxOpen(name ?? contactsBoxName)) {
      return hive.box<Contact>(name ?? contactsBoxName).values.toList();
    }
    return [];
  }

  @override
  Future<void> createContact(Contact contact) {
    final contactBox = hive.box<Contact>(contactsBoxName);
    return contactBox.put(contact.id, contact);
  }

  @override
  Future<void> updateContact(Contact contact) {
    final contactBox = hive.box<Contact>(contactsBoxName);
    final index = getContacts().indexWhere((e) => e.id == contact.id);
    return contactBox.putAt(index, contact);
  }

  @override
  bool deleteContact(String id) {
    final contactBox = hive.box<Contact>(contactsBoxName);
    contactBox.delete(id);
    if (contactBox.get(id) != null) {
      return false;
    }
    return true;
  }

  List<Contact> convertToContact(List<local.Contact> contacts) {
    Contact contact;
    return contacts.map((value) {
      final name = value.givenName ?? value.displayName ?? 'Unknown';
      final number = value.phones == null || value.phones!.isEmpty
          ? ''
          : value.phones!.first.value ?? '';
      final email = value.emails == null || value.emails!.isEmpty
          ? ''
          : value.emails!.first.value ?? '';
      // Checks if the contact already exist and returns it
      // and if it does not creates a new one.
      contact = getContacts().firstWhere(
        (element) => element.name == name || element.number == number,
        orElse: () => Contact(
          id: const Uuid().v1(),
          name: name,
          number: number.startsWith(name.characters.first) ? '' : number,
          email: email,
          group: Group.non,
        ),
      );
      return contact;
    }).toList();
<<<<<<< HEAD
    final contactBox = Hive.box<Contact>(contactsBoxName);
    await contactBox.putAll(result.asMap());

    // final contactBox = Hive.box<ContactList>(contactListBoxName);
    // await contactBox.put(contactsBoxName, ContactList(result));
  }

  @override
  List<Contact> getContacts() =>
      Hive.box<Contact>(contactsBoxName).values.toList();

  @override
  Future<int> createContact(
      String name, String number, String email, Group group) {
    // final contactBox = Hive.box<ContactList>(contactListBoxName);
    // final contacts = [...getContacts()];
    // contacts.add(Contact(name: name, number: number, group: group));
    // contactBox.put(getContacts().length + 1, ContactList(contacts));
    final contactBox = Hive.box<Contact>(contactsBoxName);
    return contactBox.add(Contact(name: name, number: number, group: group));
=======
>>>>>>> 5dabbd921a7b2a455bbf1705d0ae04094b86292e
  }

  static void addContact() {}
}
