import 'package:flutter/material.dart';
import 'package:encrypthat/constants/constants.dart' as constants;
import 'package:go_router/go_router.dart';

import '../icons.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 0) {
        context.go('/');
      } else if (index == 1) {
        context.go('/views/keys_page_view');
      } else if (index == 2) {
        context.go('/views/keys_page_view');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
      selectedIconTheme:
          const IconThemeData(color: constants.selectedItemColor),
      unselectedIconTheme:
          const IconThemeData(color: constants.unselectedItemColor),
      backgroundColor: constants.bottomNavBarColor,
      iconSize: 32,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(CustomIcons.bluetooth),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(CustomIcons.key),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_document),
          label: '',
        ),
      ],
      currentIndex: _currentIndex,
      onTap: _onItemTapped,
    );
  }
}
