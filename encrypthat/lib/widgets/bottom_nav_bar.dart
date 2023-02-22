import 'package:flutter/material.dart';
import 'package:encrypthat/constants/constants.dart' as constants;
import 'package:encrypthat/utils/icons.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.onPressed});
  final Function onPressed;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    widget.onPressed(index);

    setState(() {
      _currentIndex = index;
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
