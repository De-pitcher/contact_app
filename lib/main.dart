import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'data/hive_db.dart';
import 'permission_checker.dart';
import 'screens/my_home_screen.dart';
import 'utils/app_theme.dart';
import 'widgets/empty_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveDb hiveDb = HiveDb(Hive);
  await hiveDb.initializeDb();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final permissionStatus = HiveDb(Hive).getPermission();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(context),
      // home: FutureBuilder(
      //   future: permissionStatus,
      //   builder: (_, permissionSnapshot) {
      //     if (permissionSnapshot.connectionState == ConnectionState.waiting) {
      //       return const LoadingWidget(info: '');
      //     }
      //     if (permissionSnapshot.hasData) {
      //       if (permissionSnapshot.data == null ||
      //           permissionSnapshot.data == false) {
      //         return const PermisionChecker();
      //       }
      //       if(permissionSnapshot.data!) {
      //         return const MyHomeScreen();
      //       }

      //     }
      //     if(permissionSnapshot.hasError) {
      //       return const EmptyWidget();
      //     }
      //     return const MyHomeScreen();

      //   },
      // ),
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
