import 'package:azlistview/azlistview.dart';
import 'package:contact_app/widgets/contact_title.dart';
import 'package:flutter/material.dart';

import '../models/contact.dart';

class _AzItem extends ISuspensionBean {
  final String name;
  final String number;
  final String tag;

  _AzItem({
    required this.name,
    required this.number,
    required this.tag,
  });
  @override
  String getSuspensionTag() => tag;
}

class AlphabeticScrollPage extends StatefulWidget {
  final List<String> items;
  const AlphabeticScrollPage({super.key, required this.items});

  @override
  State<AlphabeticScrollPage> createState() => _AlphabeticScrollPageState();
}

class _AlphabeticScrollPageState extends State<AlphabeticScrollPage> {
  List<_AzItem> items = [];
  @override
  void initState() {
    initList(widget.items);
    super.initState();
  }

  void initList(List<String> items) {
    this.items = items
        .map(
          (item) =>
              _AzItem(name: item, number: item, tag: item[0].toUpperCase()),
        )
        .toList();
    SuspensionUtil.sortListBySuspensionTag(this.items);
    SuspensionUtil.setShowSuspensionStatus(this.items);
  }

  @override
  Widget build(BuildContext context) {
    return AzListView(
      data: items,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final contact = items[index];
        return _buildListItem(contact);
      },
      indexHintBuilder: (_, hint) => Container(
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

  Widget _buildListItem(_AzItem item) {
    final tag = item.getSuspensionTag();
    final offstage = !item.isShowSuspension;
    return Column(
      children: [
        Offstage(
          offstage: offstage,
          child: buildHeader(tag),
        ),
        ContactTile(
          name: item.name,
          number: item.number,
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
