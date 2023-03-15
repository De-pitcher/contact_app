import 'package:hive/hive.dart';

part 'group.g.dart';

@HiveType(typeId: 1)
enum Group {
  @HiveField(0)
  family,
  @HiveField(1)
  favorite,
  @HiveField(2)
  custom,
  @HiveField(3)
  non
}

const groupString = <Group, String>{
  Group.family: 'Family',
  Group.favorite: 'Favorite',
  Group.custom: 'Custom',
  Group.non: 'Non',
};
