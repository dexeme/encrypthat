import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEDevices extends StatefulWidget {
  const BLEDevices({Key? key}) : super(key: key);
  @override
  State<BLEDevices> createState() => _BLEDevicesState();
}

class _BLEDevicesState extends State<BLEDevices> {
  final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  void scanResults(List<ScanResult> results) {
    for (ScanResult r in results) {
      log(r.device.name);
    }
  }

  void startScan() {
    flutterBlue
        .scan(
      timeout: const Duration(seconds: 10),
    )
        .listen((scanResult) {
      log(scanResult.device.name);
    });
  }

  void stopScan() {
    flutterBlue.stopScan();
  }

  void listDevices() {
    flutterBlue.connectedDevices.then((devices) {
      for (BluetoothDevice device in devices) {
        log(device.name);
      }
    });
  }

  void connectToDevice() {
    flutterBlue.connectedDevices.then((devices) {
      for (BluetoothDevice device in devices) {
        log(device.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispositivos BLE'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  startScan();
                },
                child: const Text('Scan')),
            TextButton(
                onPressed: () {
                  listDevices();
                },
                child: const Text('Listar Dispositivos')),
            TextButton(
                onPressed: () {
                  connectToDevice();
                },
                child: const Text('Conectar ao Dispositivo')),
            TextButton(
                onPressed: () {
                  stopScan();
                },
                child: const Text('Parar Scan'))
          ],
        ),
      ),
    );
  }
}
