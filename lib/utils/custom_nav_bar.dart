import 'package:flutter/material.dart';

import 'app_color.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onItemTapped;
  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.book_online,
            size: 32,
            color:
                selectedIndex == 0 ? AppColor.accentColor : AppColor.secondary,
          ),
          label: 'All Contacts',
          backgroundColor: AppColor.primary,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.group,
            size: 32,
            color:
                selectedIndex == 1 ? AppColor.accentColor : AppColor.secondary,
          ),
          label: 'Groups',
          backgroundColor: AppColor.primary,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            size: 32,
            color:
                selectedIndex == 2 ? AppColor.accentColor : AppColor.secondary,
          ),
          label: 'Profile',
          backgroundColor: AppColor.primary,
        ),
      ],
      type: BottomNavigationBarType.shifting,
      currentIndex: selectedIndex,
      selectedItemColor: AppColor.accentColor,
      iconSize: 40,
      onTap: onItemTapped,
      elevation: 5,
    );
  }
}
