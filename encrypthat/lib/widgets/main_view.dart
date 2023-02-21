import 'package:encrypthat/icons.dart';
import 'package:encrypthat/views/home_page_view.dart';
import 'package:encrypthat/views/keys_page_view.dart';
import 'package:encrypthat/views/signature_page_view.dart';
import 'package:encrypthat/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:encrypthat/constants/constants.dart' as constants;

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}


class _MainViewState extends State<MainView> {
  int viewIndex = 0;
  List<Widget> views = [
    const HomePage(),
    const KeysPage(),
    const SignaturePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backgroundColor,
      appBar: AppBar(
        title: const Text('ENCRYPTHAT', style: constants.boldFont),
        leading: const Icon(CustomIcons.logo),
        backgroundColor: constants.appBarColor,
      ),
      bottomNavigationBar: BottomNavBar(onPressed: (index) {
        //if 
        
        setState(() {
          viewIndex = index;
        });
      }),
      body: views[viewIndex],
    );
  }
}
