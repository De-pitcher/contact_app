import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../models/group.dart';
import 'contact_details_widget.dart';

class ContactTile extends StatelessWidget {
  final String tag;
  final String id;
  final String name;
  final String number;
  final String email;
  final Uint8List? imageUrl;
  final Group group;
  const ContactTile({
    super.key,
    required this.name,
    required this.number,
    this.imageUrl,
    this.group = Group.non,
    required this.tag,
    required this.id,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    var bgColor = Colors.accents[math.Random().nextInt(Colors.accents.length)];
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      child: ListTile(
        tileColor: Theme.of(context).scaffoldBackgroundColor,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ContactDetailsWidget(
                name: name,
                color: bgColor,
                imageUrl: imageUrl,
                number: number.toString(),
                email: email,
                location: 'Location',
                id: id,
                group: group,
              ),
            ),
          );
        },
        leading: tag == '#'
            ? null
            : CircleAvatar(
                backgroundColor: bgColor,
                child: imageUrl == null || imageUrl!.isEmpty
                    ? Text(
                        tag,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    : Image.memory(imageUrl!),
              ),
        title: Text(
          name,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: number == ''
            ? null
            : Text(
                number,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
      ),
    );
  }
}
