import '../models/contact.dart';
import '../models/group.dart';

abstract class HiveDbRepository {
  Future initializeDb();

  Future<void> setPermission(bool value);

  bool? getPermission([String? name]);

  Future<void> initializeContact(List<Contact> contacts);

  List<Contact> getContacts([String? name]);

  Future<int> createContact(
    String name,
    String number,
    String email,
    Group group,
  );
}
