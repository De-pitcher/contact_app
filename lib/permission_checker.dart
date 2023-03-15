import 'package:contact_app/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart' as local;

import 'constants/constants.dart';
import 'models/contact.dart';
import 'models/contact_list.dart';
import 'models/group.dart';
import 'screens/my_home_screen.dart';

class PermisionChecker extends StatefulWidget {
  const PermisionChecker({super.key});

  @override
  State<PermisionChecker> createState() => _PermisionCheckerState();
}

class _PermisionCheckerState extends State<PermisionChecker> {
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

  Future<bool> _initialzedContacts() async {
    await local.ContactsService.getContacts(withThumbnails: false).then((data) {
      if (data.isEmpty) {
        final contactBox = Hive.box<ContactList>(contactListBoxName);
        if (data.length > contactBox.length) {
          final contacts = data.map((value) {
            final name = value.givenName ?? value.displayName ?? 'Unknown';
            final number = value.phones == null || value.phones!.isEmpty
                ? ''
                : value.phones!.first.value ?? '';
            return Contact(
              name: name,
              number: number.startsWith(name.characters.first) ? '' : number,
              group: Group.non,
            );
          }).toList();

          contactBox.put('contact', ContactList(contacts));
          return false;
        }
      }
    });
    return true;
  }

  void _handleInvalidPermissions(
    PermissionStatus permissionStatus,
  ) {
    if (permissionStatus == PermissionStatus.denied) {
      const snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.granted) {
      Hive.box<bool>(permissionStatusBoxName).put('permission', true);
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
            _initialzedContacts();
            return FutureBuilder(
              future: _initialzedContacts(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget(info: 'Initializing Contacts');
                }
                if (snapshot.hasData) {
                  if (snapshot.data!) {
                    return const MyHomeScreen();
                  }
                }
                return const Text('Could\'nt load contacts');
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
