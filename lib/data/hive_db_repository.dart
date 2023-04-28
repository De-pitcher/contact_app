import 'package:contacts_service/contacts_service.dart' as local;

import '../models/contact.dart';
import '../models/group.dart';

abstract class HiveDbRepository {
  Future initializeBoxes();

  bool? getPermission();

  Future<void> setPermission(bool value);

  Future initializeContact(List<local.Contact> contacts);

  List<Contact> getContacts();

  Future<int> createContact(String name, String number, String email, Group group);
}
