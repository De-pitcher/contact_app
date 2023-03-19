import 'package:azlistview/azlistview.dart';
import 'package:contact_app/widgets/contact_title.dart';
import 'package:flutter/material.dart';

import '../models/contact.dart';

class AlphabeticScrollPage extends StatefulWidget {
  final List<Contact> contacts;
  const AlphabeticScrollPage({super.key, required this.contacts});

  @override
  State<AlphabeticScrollPage> createState() => _AlphabeticScrollPageState();
}

class _AlphabeticScrollPageState extends State<AlphabeticScrollPage> {
  List<Contact> contacts = [];

  @override
  void initState() {
    initList(widget.contacts);
    super.initState();
  }

  void initList(List<Contact> contacts) {
    this.contacts = contacts;
    SuspensionUtil.sortListBySuspensionTag(this.contacts);
    SuspensionUtil.setShowSuspensionStatus(this.contacts);
  }


  @override
  Widget build(BuildContext context) {
    return AzListView(
      data: contacts,
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return _buildListItem(contact);
      },
      indexHintBuilder: (_, hint) => Expanded(
        child: Container(
          alignment: Alignment.center,
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: Text(
            hint,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
      ),
      indexBarMargin: const EdgeInsets.all(10),
      indexBarOptions: const IndexBarOptions(
        needRebuild: true,
        selectTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        selectItemDecoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        indexHintAlignment: Alignment.centerRight,
        indexHintOffset: Offset(-20, 0),
      ),
    );
  }

  Widget _buildListItem(Contact contact) {
    final tag = contact.getSuspensionTag();
    final offstage = !contact.isShowSuspension;
    return Column(
      children: [
        Offstage(
          offstage: offstage,
          child: buildHeader(tag),
        ),
        ContactTile(
          name: contact.name,
          number: contact.number,
          group: contact.group,
        ),
      ],
    );
  }

  Widget buildHeader(String tag) => Container(
        height: 40,
        margin: const EdgeInsets.only(right: 16.0),
        padding: const EdgeInsets.only(left: 16.0),
        alignment: Alignment.centerLeft,
        color: Colors.grey[300],
        child: Text(
          tag,
          softWrap: false,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
