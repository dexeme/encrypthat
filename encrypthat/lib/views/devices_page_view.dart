import 'package:encrypthat/services/bluetooth/functions/ble_devices_scanner.dart';
import 'package:encrypthat/services/bluetooth/widgets/panels/devices_panel.dart';
import 'package:encrypthat/utils/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:encrypthat/constants/constants.dart' as constants;
import 'package:encrypthat/services/bluetooth/widgets/buttons/start_scan_button.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  BLEDevicesScanner scanner = BLEDevicesScanner.instance;
  StorageManager storage = StorageManager.instance;
  List<String> _devicesList = [];
  String? _lastScanTime;

  @override
  void initState() {
    super.initState();
    _devicesList = scanner.devices;
    _lastScanTime = scanner.lastScanTime;
  }

  get devicesList => _devicesList;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            child: DevicesPanel(
              devicesList: _devicesList.toSet().toList(), // Avoid duplicates
              lastScanTime: _lastScanTime,
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          Column(
            children: [
              _lastScanTime == null
                  ? const Text('Última verificação: Nenhum Scan Realizado',
                      style: constants.regularFont, textAlign: TextAlign.center)
                  : Text('Última verificação: $_lastScanTime',
                      style: constants.regularFont,
                      textAlign: TextAlign.center),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StartScanButton(onPressed: () {
                    final devicesReturn = scanner.startScan();
                    final lastScanTime = scanner.lastScanTime;
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
    );
  }
}
