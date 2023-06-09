import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart' as local;

import 'data/hive_db.dart';
import 'screens/my_home_screen.dart';
import 'utils/app_color.dart';
import 'widgets/empty_widget.dart';

class PermisionChecker extends StatefulWidget {
  const PermisionChecker({super.key});

  @override
  State<PermisionChecker> createState() => _PermisionCheckerState();
}

class _PermisionCheckerState extends State<PermisionChecker> {
  final HiveDb _hiveDb = HiveDb(Hive);

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Future _initialzedContacts() async {
    final convertedContact = _hiveDb.convertToContact(
        await local.ContactsService.getContacts(withThumbnails: false));
    return _hiveDb.initializeContact(convertedContact);
  }

  Future<bool> _shouldInitialize() async {
    final contacts = _hiveDb.getContacts();
    bool result = false;

    if (contacts.isEmpty) {
      if (kDebugMode) {
        print('Debug: ===> isEmpty');
      }

      result = true;
    } else {
      if (kDebugMode) {
        print('Debug: ===> IsNotEmpty');
      }
      await local.ContactsService.getContacts(withThumbnails: false)
          .then((data) {
        final shouldUpdate =
            data.length > contacts.length;
        if (shouldUpdate) {
          if (kDebugMode) {
            print('Debug: ===> shouldUpdate');
          }
          result = true;
        } else {
          if (kDebugMode) {
            print('Debug: ===> shouldNotUpdate');
          }

          result = false;
        }
      });
    }
    if (result) await _initialzedContacts();
    return result;
  }

  void _handleInvalidPermissions(
    PermissionStatus permissionStatus,
  ) {
    if (permissionStatus == PermissionStatus.denied) {
      const snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.granted) {
      _hiveDb.setPermission(true);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      const snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getContactPermission(),
      builder: (context, permissionSnapshot) {
        if (permissionSnapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget(
            info: 'Checking permission',
          );
        } else if (permissionSnapshot.hasData) {
          _handleInvalidPermissions(permissionSnapshot.data!);
          if (permissionSnapshot.data! == PermissionStatus.granted) {
            return FutureBuilder(
              future: _shouldInitialize(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget(info: 'Initializing Contacts');
                }
                if (snapshot.hasData) {
                  return const MyHomeScreen();
                }
                if(snapshot.hasError) {
                  return  Scaffold(
                  body: Center(
                    child: Text('An error occurred: ${snapshot.error.toString()}'),
                  ),
                );
                }
                return const EmptyWidget();
              },
            );
          }
        }
        return const Scaffold(
          body: Center(
            child: Text('Ooops! Something went wrong!'),
          ),
        );
      },
    );
  }
}

class LoadingWidget extends StatelessWidget {
  final String info;
  const LoadingWidget({
    super.key,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$info...'),
          const SizedBox(
            width: double.infinity,
            height: 20,
          ),
          const CircularProgressIndicator(
            backgroundColor: AppColor.primary,
            color: AppColor.secondary,
            strokeWidth: 5,
          ),
        ],
      ),
    );
  }
}
