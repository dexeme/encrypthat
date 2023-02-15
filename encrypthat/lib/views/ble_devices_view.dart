import 'dart:math';

import 'package:encrypthat/services/bluetooth/ble_devices_scanner.dart';
import 'package:encrypthat/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:encrypthat/services/bluetooth/widgets/start_scan_button.dart';
import 'package:encrypthat/services/bluetooth/widgets/scan_result_panel.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEDevicesView extends StatefulWidget {
  const BLEDevicesView({Key? key}) : super(key: key);

  @override
  State<BLEDevicesView> createState() => _BLEDevicesViewState();
}

class _BLEDevicesViewState extends State<BLEDevicesView> {
  BLEDevicesScanner scanner = BLEDevicesScanner.instance;
  StorageManager storage = StorageManager.instance;
  List<String> _devicesList = [];
  DateTime? _lastScanTime;
  String lastScanTime = 'Nenhum Scan Realizado';
  int secondsRemaining = 5;
  List devices = [];

  void callback({
    required List<String> devices,
    required String lastScanTime,
  }) {
    setState(() {
      this.devices = devices;
      this.lastScanTime = lastScanTime;
    });
  }

  @override
  void initState() {
    super.initState();
    _initDevices();
  }

  void _initDevices() async {
    final data = await storage.readFileContents(filename: 'devices.txt');
    setState(() {
      devices = data.split(',').toSet().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BLE Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dispositivos BLE'),
        ),
        body: Column(
          children: [
            StartScanButton(
              onPressed: () {
                devices.clear();
                final devicesReturn = scanner.startScan();
                final lastScanTime = DateTime.now();
                setState(() {
                  _lastScanTime = lastScanTime;
                  _devicesList = devicesReturn;
                });
              },
            ),
            Expanded(
              child: ScanResultPanel(
                devicesList: _devicesList.map((device) => device).toList(),
                lastScanTime: _lastScanTime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
