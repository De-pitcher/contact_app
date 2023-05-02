import 'package:azlistview/azlistview.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'group.dart';

part 'contact.g.dart';

@HiveType(typeId: 0)
class Contact extends ISuspensionBean {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String number;
  @HiveField(3, defaultValue: Group.non)
  Group group;

  Contact({required this.id, required this.name, required this.number, this.group = Group.non});

  @override
  String getSuspensionTag() {
    String result = '#';
    if (name.toUpperCase().contains(RegExp(r'[A-Z]'))) {
      if (name[0].codeUnitAt(0) == 8206) {
        result = name[1];
      } else if (int.tryParse(name[0]) != null) {
        result = '#';
      } else {
        result = name[0];
      }
    }
    return result;
  }
}
