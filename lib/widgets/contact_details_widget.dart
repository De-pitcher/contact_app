import 'dart:typed_data';

import 'package:contact_app/widgets/contact_widget.dart';
import 'package:flutter/material.dart';

import '../models/group.dart';
import 'contact_detail_tile.dart';
import 'details_widget.dart';
import 'icon_card.dart';

enum ContactAction { edit, delete }

class ContactDetailsWidget extends StatelessWidget {
  const ContactDetailsWidget({
    super.key,
    required this.name,
    this.imageUrl,
    required this.number,
    required this.location,
    this.email,
    this.group,
    required this.color,
  });

  final Color color;
  final String? email;
  final String? group;
  final Uint8List? imageUrl;
  final String location;
  final String name;
  final String number;

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
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
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
                          group: Group.non,
                          title: 'Edit Contact',
                        ),
                      ),
                    );
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
                      subtitle: number,
                      trailing: SizedBox(
                        width: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            IconCard(icon: Icons.message),
                            SizedBox(width: 10),
                            IconCard(icon: Icons.phone),
                          ],
                        ),
                      ),
                    ),
                    ContactDetailTile(
                      title: 'Email',
                      subtitle: email ?? 'nil',
                      trailing: const IconCard(icon: Icons.email),
                    ),
                    ContactDetailTile(
                      title: 'Group',
                      subtitle: group ?? 'nil',
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
                          children: const [
                            IconCard(icon: Icons.telegram),
                          ],
                        ),
                      ),
                    ),
                    ContactDetailTile(
                      title: 'WhatsApp',
                      subtitle: number,
                      trailing: const IconCard(icon: Icons.wechat),
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
