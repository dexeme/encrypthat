// ignore_for_file: prefer_const_constructors

import 'package:encrypthat/services/bluetooth/ble_devices.dart';
import 'package:encrypthat/views/keys_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desafio Labsec',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // insert a new route here
      home: const MyHomePage(title: 'Desafio Labsec'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BLEDevices()),
                  );
                },
                child: const Text('Dispositivos BLE'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => KeysView()),
                    );
                  },
                  child: const Text('Generate RSA Key')),
            ])
          ],
        ),
      ),
    );
  }
}
