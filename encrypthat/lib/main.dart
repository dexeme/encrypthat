import 'package:encrypthat/views/main_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Encrypthat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainView(),
    );
  }
}
