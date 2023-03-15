import 'package:hive_flutter/hive_flutter.dart';

import 'contact.dart';

part 'contact_list.g.dart';

@HiveType(typeId: 2)
class ContactList {
  @HiveField(0)
  final List<Contact> contacts;
  const ContactList(this.contacts);

  ContactList fromJson(Map<int, Contact> json) =>
      ContactList(json.values.toList());

  Map<int, Contact> toMap() => contacts.asMap();
}
