import 'dart:developer';

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
    hive.registerAdapter<Group>(GroupAdapter());
  }

  @override
  bool? getPermission() {
    if (hive.isBoxOpen(permissionStatusBoxName)) {
      final permissionBox = hive.box<bool>(permissionStatusBoxName);
      return permissionBox.get(permissionStatusBoxName);
    }
    return null;
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
  List<Contact> getContacts() {
    if (hive.isBoxOpen(contactsBoxName)) {
      return hive.box<Contact>(contactsBoxName).values.toList();
    }
    return [];
  }

  @override
  Future<int> createContact(
    String name,
    String number,
    String email,
    Group group,
  ) {
    final contactBox = hive.box<Contact>(contactsBoxName);
    final contact = Contact(
      name: name,
      number: number,
      group: group,
    );
    return contactBox.add(contact);
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

  List<Contact> convertToContact(List<local.Contact> contacts) {
    return contacts.map((value) {
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
  }
}
