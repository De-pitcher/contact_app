import '../models/contact.dart';

abstract class HiveDbRepository {
  Future initializeDb();

  Future<void> setPermission(bool value);

  bool? getPermission([String? name]);

  Future<void> initializeContact(List<Contact> contacts);

  List<Contact> getContacts([String? name]);

  Future<void> createContact(Contact contact);

  Future<void> updateContact(Contact contact);
}
