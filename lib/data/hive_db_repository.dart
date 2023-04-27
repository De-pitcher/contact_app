import 'package:contacts_service/contacts_service.dart' as local;

import '../models/contact.dart';

abstract class HiveDbRepository {
  Future initializeBoxes();

  bool? getPermission();

  void setPermission(bool value);

  Future initializeContact(List<local.Contact> contacts);

  List<Contact> getContacts();
}
