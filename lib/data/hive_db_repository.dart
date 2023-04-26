import 'package:contacts_service/contacts_service.dart' as local;

import '../models/contact.dart';

abstract class HiveDbRepository {
  Future initializeBoxes();

  bool? getPermission();

  List<Contact> getContacts(List<local.Contact> contacts);
}
