import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../models/group.dart';
import '../utils/app_color.dart';
import 'contact_details_widget.dart';

class ContactTile extends StatelessWidget {
  final String name;
  final String number;
  final Uint8List? imageUrl;
  final Group? group;
  const ContactTile({
    super.key,
    required this.name,
    required this.number,
    this.imageUrl,
    this.group,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      elevation: 0,
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ContactDetailsWidget(
                name: name,
                imageUrl: imageUrl,
                number: number.toString(),
                location: 'Location',
                group: groupString[group],
              ),
            ),
          );
        },
        leading: CircleAvatar(
          // child: Image.asset(imageUrl),
          backgroundColor: AppColor.accentColor,
          child: imageUrl == null || imageUrl!.isEmpty
              ? const Icon(
                  Icons.person,
                  color: AppColor.primary,
                )
              : Image.memory(imageUrl!),
        ),
        title: Text(name),
        subtitle: number == '' ? null : Text(number),
        // trailing: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(Icons.more_horiz),
        // ),
      ),
    );
  }
}
