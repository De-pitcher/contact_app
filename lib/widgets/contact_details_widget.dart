import 'dart:io';
import 'dart:typed_data';

import 'package:contact_app/widgets/contact_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../data/hive_db.dart';
import '../models/group.dart';
import 'contact_detail_tile.dart';
import 'details_widget.dart';
import 'icon_card.dart';

enum ContactAction { edit, delete }

class ContactDetailsWidget extends StatelessWidget {
  final Color color;
  final String? email;
  final Group group;
  final Uint8List? imageUrl;
  final String location;
  final String name;
  final String number;
  final String id;
  const ContactDetailsWidget({
    super.key,
    required this.name,
    this.imageUrl,
    required this.number,
    required this.location,
    this.email,
<<<<<<< HEAD
    this.group,
    required this.color, ///////////////////////////////////////////////////////////////////////////////////
=======
    this.group = Group.non,
    required this.color,
    required this.id,
>>>>>>> 5dabbd921a7b2a455bbf1705d0ae04094b86292e
  });

  void _launchUrl(String scheme, [String? path]) async {
    final url = Uri(scheme: scheme, path: path);
    if (!await launchUrl(url)) {
      throw 'Application unable to open dialer.';
    }
  }

  void _launchWhatsapp(String number) async {
    String url;
    if (Platform.isAndroid) {
      url = 'whatsapp://send?phone=$number';
    } else {
      url = 'whatsapp://wa.me/$number';
    }
    if (!await launchUrlString(url)) {
      throw 'Application unable to open dialer.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: 60,
            expandedHeight: 250,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                name,
                textScaleFactor: 1,
                style: name.length < 10
                    ? Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).appBarTheme.backgroundColor,
                        )
                    : Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).appBarTheme.backgroundColor,
                        ),
              ),
              background: Hero(
                tag: const Key('UserImage'),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: color,
                    child: imageUrl == null || imageUrl!.isEmpty
                        ? Text(
                            name.substring(0, 1),
                            style: Theme.of(context).textTheme.headlineLarge,
                          )
                        : Image.memory(
                            imageUrl!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
            ),
            actions: [
              PopupMenuButton(
                itemBuilder: (_) => [
                  PopupMenuItem<ContactAction>(
                    value: ContactAction.edit,
                    child: Text(
                      'Edit',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  PopupMenuItem<ContactAction>(
                    value: ContactAction.delete,
                    child: Text(
                      'Delete',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == ContactAction.edit) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ContactWidget(
                          name: name,
                          number: number,
                          email: email!,
                          group: group,
                          id: id,
                          title: 'Edit Contact',
                        ),
                      ),
                    );
                  } else if (value == ContactAction.delete) {
                    final result = HiveDb(Hive).deleteContact(id);
                    if (result) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Contact deleted!'),
                        ),
                      );
                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Something went wrong!'),
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  }
                },
              )
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                DetailsWidget(
                  height: 95 * 3,
                  title: 'Details',
                  children: [
                    ContactDetailTile(
                      title: 'Number',
                      subtitle: number == '' ? 'nil' : number,
                      trailing: SizedBox(
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconCard(
                              icon: Icons.message,
                              onPressed: () => _launchUrl('sms'),
                            ),
                            const SizedBox(width: 10),
                            IconCard(
                              icon: Icons.phone,
                              onPressed: () => _launchUrl('tel', number),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ContactDetailTile(
                      title: 'Email',
                      subtitle: email ?? 'nil',
                      trailing: IconCard(
                        icon: Icons.email,
                        onPressed: () => _launchUrl('mailto', email),
                      ),
                    ),
                    ContactDetailTile(
                      title: 'Group',
                      subtitle: group.name,
                      trailing: const IconCard(icon: Icons.group),
                    ),
                  ],
                ),
                DetailsWidget(
                  height: 100 * 2,
                  title: 'Account Linked',
                  children: [
                    ContactDetailTile(
                      title: 'Telegram',
                      subtitle: number,
                      trailing: SizedBox(
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconCard(
                              icon: Icons.telegram,
                              onPressed: () => _launchUrl('tg', name),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ContactDetailTile(
                      title: 'WhatsApp',
                      subtitle: number,
                      trailing: IconCard(
                        icon: Icons.wechat,
                        onPressed: () => _launchWhatsapp(number),
                      ),
                    ),
                  ],
                ),
                const DetailsWidget(
                  height: 100 * 2,
                  title: 'More Options',
                  children: [
                    ContactDetailTile(
                      title: 'Shared Contant',
                    ),
                    ContactDetailTile(
                      title: 'QR Code',
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
