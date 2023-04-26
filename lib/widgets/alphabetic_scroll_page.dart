import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../models/contact.dart';
import 'contact_tile.dart';

class CustomSuspensionUtil extends SuspensionUtil {
  static void sortListBySuspensionTag(List<ISuspensionBean>? list) {
    if (list == null || list.isEmpty) return;
    list.sort((a, b) => a
        .getSuspensionTag()
        .toUpperCase()
        .compareTo(b.getSuspensionTag().toUpperCase()));
  }

  static void setShowSuspensionStatus(List<ISuspensionBean>? list) {
    if (list == null || list.isEmpty) return;
    String? tempTag;
    for (int i = 0, length = list.length; i < length; i++) {
      String tag = list[i].getSuspensionTag().toLowerCase();

      if (tempTag != tag) {
        list[i].isShowSuspension = true;
        tempTag = tag;
      } else {
        list[i].isShowSuspension = false;
      }
    }
  }
}

class AlphabeticScrollPage extends StatefulWidget {
  final List<Contact> contacts;
  const AlphabeticScrollPage({super.key, required this.contacts});

  @override
  State<AlphabeticScrollPage> createState() => _AlphabeticScrollPageState();
}

class _AlphabeticScrollPageState extends State<AlphabeticScrollPage> {
  List<Contact> contacts = [];
  List<String> alphabets = [
    '#',
    ...List.generate(26, (index) => String.fromCharCode(index + 65))
  ];

  final ValueNotifier<int> _currentIndex = ValueNotifier(0);
  final ItemScrollController _itemScrollContainer = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  int value() => _itemPositionsListener.itemPositions.value
      .where((ItemPosition position) => position.itemTrailingEdge > 0)
      .reduce((ItemPosition min, ItemPosition position) =>
          position.itemTrailingEdge < min.itemTrailingEdge ? position : min)
      .index;

  void _jumpTo(String searchLetter) {
    setState(() {
      final index = contacts
          .indexWhere((element) => element.getSuspensionTag() == searchLetter);
      if (index >= 0) _itemScrollContainer.jumpTo(index: index);
    });
  }

  void _changeCurrentIndex(int value) {
    _currentIndex.value = alphabets.indexWhere(
        (element) => element == contacts[value].name[0].toUpperCase());
  }

  @override
  void initState() {
    initList(widget.contacts);
    _itemPositionsListener.itemPositions.addListener(() {
      _changeCurrentIndex(value());
      _currentIndex.value = alphabets.indexWhere(
          (element) => element == contacts[value()].name[0].toUpperCase());
      print('Debug (itemPosition): ${_currentIndex.value}');
      print('Debug (_searchIndex): ${value()}');
      print('Debug (Contact current index): $_currentIndex');
    });

    super.initState();
  }

  void initList(List<Contact> contacts) {
    this.contacts = contacts;
    CustomSuspensionUtil.sortListBySuspensionTag(this.contacts);
    CustomSuspensionUtil.setShowSuspensionStatus(this.contacts);
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 50),
            child: _list(orientation),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: alphabets.map((alpha) {
                return InkWell(
                    onTap: () => _jumpTo(alpha),
                    child: ValueListenableBuilder(
                      valueListenable: _currentIndex,
                      builder: (_, value, __) => Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: alphabets[value == -1 ? 0 : value] == alpha
                              ? Theme.of(context).colorScheme.secondary
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            alpha,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: alphabets[value == -1 ? 0 : value] ==
                                            alpha
                                        ? Theme.of(context)
                                            .scaffoldBackgroundColor
                                        : null),
                          ),
                        ),
                      ),
                    ));
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _list(Orientation orientation) => ScrollablePositionedList.builder(
        itemCount: contacts.length,
        itemBuilder: (_, index) => _buildListItem(contacts[index]),
        itemScrollController: _itemScrollContainer,
        itemPositionsListener: _itemPositionsListener,
        reverse: false,
        scrollDirection: orientation == Orientation.portrait
            ? Axis.vertical
            : Axis.horizontal,
      );

  Widget _buildListItem(Contact contact) {
    final offstage = !contact.isShowSuspension;
    return Column(
      children: [
        Offstage(
          offstage: offstage,
          child: buildHeader(contact.getSuspensionTag()),
        ),
        ContactTile(
          name: contact.name,
          number: contact.number,
          group: contact.group,
          tag: contact.getSuspensionTag(),
        ),
      ],
    );
  }

  Widget buildHeader(String tag) => Container(
        height: 40,
        margin: const EdgeInsets.only(right: 16.0),
        padding: const EdgeInsets.only(left: 16.0),
        alignment: Alignment.centerLeft,
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
