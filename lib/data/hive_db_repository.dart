import '../models/contact.dart';
import '../models/group.dart';

abstract class HiveDbRepository {
  Future initializeBoxes();

  bool? getPermission();

  Future<void> setPermission(bool value);

  Future<void> initializeContact(List<Contact> contacts);

  List<Contact> getContacts();

  Future<int> createContact(
    String name,
    String number,
    String email,
    Group group,
  );
}
