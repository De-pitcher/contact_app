import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'constants/constants.dart';
import 'models/contact.dart';
import 'models/contact_list.dart';
import 'models/group.dart';
import 'permission_checker.dart';
import 'screens/my_home_screen.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<Contact>(ContactAdapter());
  Hive.registerAdapter<ContactList>(ContactListAdapter());
  Hive.registerAdapter<Group>(GroupAdapter());
  Hive.openBox<bool>(permissionStatusBoxName);
  await Hive.openBox<Contact>(contactsBoxName);
  await Hive.openBox<ContactList>(contactListBoxName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final permissionBox =
        Hive.box<bool>(permissionStatusBoxName).get(permissionStatusBoxName);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(context),
      home: permissionBox == null
          ? const PermisionChecker()
          : permissionBox
              ? const MyHomeScreen()
              : Container(),
      routes: {
        MyHomeScreen.id: (_) => const MyHomeScreen(),
      },
    );
  }
}
