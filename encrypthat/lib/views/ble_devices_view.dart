import 'package:encrypthat/services/bluetooth/ble_devices_scanner.dart';
import 'package:encrypthat/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:encrypthat/services/bluetooth/widgets/start_scan_button.dart';
import 'package:encrypthat/services/bluetooth/widgets/scan_result_panel.dart';
import 'package:go_router/go_router.dart';

class BLEDevicesView extends StatefulWidget {
  const BLEDevicesView({Key? key}) : super(key: key);

  @override
  State<BLEDevicesView> createState() => _BLEDevicesViewState();
}

class _BLEDevicesViewState extends State<BLEDevicesView>
    with AutomaticKeepAliveClientMixin {
  BLEDevicesScanner scanner = BLEDevicesScanner.instance;
  StorageManager storage = StorageManager.instance;
  List<String> _devicesList = [];
  DateTime? _lastScanTime;
  String lastScanTime = 'Nenhum Scan Realizado';
  int secondsRemaining = 5;
  List devices = [];

  @override
  void initState() {
    super.initState();
    _initDevices();
  }

  void _initDevices() async {
    final data = await storage.readFileContents(filename: 'devices.txt') == ''
        ? 'Nenhum Dispositivo Encontrado'
        : await storage.readFileContents(filename: 'devices.txt');
    setState(() {
      _devicesList = data.split(',').toSet().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
            TextButton(
                onPressed: () => context.go('/'), child: const Text('Voltar')),
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

  @override
  bool get wantKeepAlive => true;
}
