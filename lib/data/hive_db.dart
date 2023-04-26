import 'package:contacts_service/contacts_service.dart' as local;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/constants.dart';
import '../models/contact_list.dart';
import '../models/group.dart';
import 'hive_db_repository.dart';
import '/models/contact.dart';

class HiveDb implements HiveDbRepository {
  @override
  Future initializeBoxes() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Contact>(ContactAdapter());
    Hive.registerAdapter<ContactList>(ContactListAdapter());
    Hive.registerAdapter<Group>(GroupAdapter());
    await Hive.openBox<bool>(permissionStatusBoxName);
    await Hive.openBox<Contact>(contactsBoxName);
    await Hive.openBox<ContactList>(contactListBoxName);
  }

  @override
  bool? getPermission() =>
      Hive.box<bool>(permissionStatusBoxName).get(permissionStatusBoxName);

  @override
  List<Contact> getContacts(List<local.Contact> contacts) {
    List<Contact> result = [];

    final contactBox = Hive.box<ContactList>(contactListBoxName);
    
      result = contacts.map((value) {
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
      contactBox.put(contactsBoxName, ContactList(result)).then((value) {
        if (kDebugMode) {
          print('ContactApp debug: Contact successfully added!');
        }
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print('ContactApp debug: Contact was not added!');
        }
      });

    return result;
  }
}
