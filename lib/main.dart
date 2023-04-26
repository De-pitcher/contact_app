import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'constants/constants.dart';
import 'data/hive_db.dart';
import 'models/contact.dart';
import 'models/contact_list.dart';
import 'permission_checker.dart';
import 'screens/my_home_screen.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveDb hiveDb = HiveDb();
  await hiveDb.initializeBoxes();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final permissionStatus = HiveDb().getPermission();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(context),
      home: permissionStatus == null
          ? const PermisionChecker()
          : permissionStatus
              ? const MyHomeScreen()
              : const PermisionChecker(),
      routes: {
        MyHomeScreen.id: (_) => const MyHomeScreen(),
      },
    );
  }
}
