import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/group.dart';
import 'contact_details_widget.dart';

class ContactTile extends StatelessWidget {
  final String name;
  final String number;
  final String tag;
  final Uint8List? imageUrl;
  final Group? group;
  const ContactTile({
    super.key,
    required this.name,
    required this.number,
    this.imageUrl,
    this.group,
    required this.tag,
  });

  void _launchDialer(String number) async {
    print('Debug (check number): $number');

    final url = Uri(scheme: 'tel', path: number);
    if (!await launchUrl(url)) {
      throw 'Application unable to open dialer.';
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(' - Name => $name');

    var bgColor =
        Colors.primaries[math.Random().nextInt(Colors.primaries.length)];
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      elevation: 0,
      child: ListTile(
        onTap: () {
          // _launchDialer(number == '' ? name : number);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ContactDetailsWidget(
                name: name,
                color: bgColor,
                imageUrl: imageUrl,
                number: number.toString(),
                location: 'Location',
                group: groupString[group],
              ),
            ),
          );
        },
        leading: tag == '#'
            ? null
            : CircleAvatar(
                backgroundColor: bgColor,
                child: imageUrl == null || imageUrl!.isEmpty
                    ? Text(tag)
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
        // trailing: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(Icons.more_horiz),
        // ),
      ),
    );
  }
}
