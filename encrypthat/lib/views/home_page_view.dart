import 'package:encrypthat/services/bluetooth/ble_devices_scanner.dart';
import 'package:encrypthat/services/bluetooth/widgets/scan_result_panel.dart';
import 'package:encrypthat/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:encrypthat/constants/constants.dart' as constants;
import 'package:encrypthat/services/bluetooth/widgets/start_scan_button.dart';
import '../icons.dart';

import '../widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BLEDevicesScanner scanner = BLEDevicesScanner.instance;
  StorageManager storage = StorageManager.instance;
  List<String> _devicesList = [];
  List devices = [];
  DateTime? _lastScanTime;
  String lastScan() {
    if (_lastScanTime == null) {
      return 'Nenhum Scan Realizado';
    } else {
      return '${_lastScanTime!.day}/${_lastScanTime!.month}/${_lastScanTime!.year} ${_lastScanTime!.hour}:${_lastScanTime!.minute}';
    }
  }

  String lastScanTime = 'Nenhum Scan Realizado';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backgroundColor,
      appBar: AppBar(
        title: const Text('ENCRYPTHAT', style: constants.boldFont),
        leading: const Icon(CustomIcons.logo),
        backgroundColor: constants.appBarColor,
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  height: 70,
                ),
                Text('DISPOSITIVOS BLE', style: constants.boldFont),
              ],
            ),
            Expanded(
              child: ScanResultPanel(
                devicesList: _devicesList.toSet().toList(), // Avoid duplicates
                lastScanTime: _lastScanTime,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Column(
              children: [
                Text(
                    'Última verificação: ${lastScan()}', 
                    style: constants.regularFont,
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StartScanButton(onPressed: () {
                      devices.clear();
                      final devicesReturn = scanner.startScan();
                      final lastScanTime = DateTime.now();
                      setState(() {
                        _lastScanTime = lastScanTime;
                        _devicesList = devicesReturn;
                      });
                    }),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
