import 'package:encrypthat/services/bluetooth/ble_devices_scanner.dart';
import 'package:encrypthat/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BLEDevicesView extends StatefulWidget {
  const BLEDevicesView({Key? key}) : super(key: key);

  @override
  State<BLEDevicesView> createState() => _BLEDevicesViewState();
}

class _BLEDevicesViewState extends State<BLEDevicesView> {
  BLEDevicesScanner scanner = BLEDevicesScanner.instance;
  StorageManager storage = StorageManager.instance;
  String lastScanTime = 'Nenhum Scan Realizado';
  List devices = [];

  DateTime getCurrentTime() {
    return DateTime.now();
  }

  @override
  void initState() {
    super.initState();
    _initDevices();
  }

  void _initDevices() async {
    final readDevices =
        await storage.readFileContents(filename: 'devices.txt') == ''
            ? 'Nenhum Dispositivo Encontrado'
            : await storage.readFileContents(filename: 'devices.txt');
    setState(() {
      devices = readDevices.split(',');
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
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton(
                onPressed: () async {
                  devices.clear();
                  final devicesList = scanner.startScan();
                  await storage.writeData(
                      filename: 'devices.txt', data: devicesList.toString());
                  setState(() {
                    lastScanTime = scanner.getLastScanTimeFormatted();
                    devices = devicesList;
                  });
                },
                child: const Text('Iniciar Scan'),
              ),
              TextButton(
                onPressed: () => context.go('/'),
                child: const Text('Voltar'),
              ),
            ]),
            Text('Último Scan: $lastScanTime'),
            Text('Dispositivos Encontrados: $devices'),
          ],
        ),
      ),
    );
  }
}
