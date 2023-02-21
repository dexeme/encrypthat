import 'package:encrypthat/storage_manager.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEDevicesScanner {
  BLEDevicesScanner._privateConstructor();
  static final BLEDevicesScanner _instance =
      BLEDevicesScanner._privateConstructor();
  static BLEDevicesScanner get instance => _instance;

  String? get lastScanTime => _lastScanTime;
  List<String> get devices => _devices;

  BLEDevicesScanner();
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  StorageManager storage = StorageManager.instance;
  String? _lastScanTime;
  List<String> _devices = [];

  List<String> startScan() {
    flutterBlue.scan(timeout: const Duration(seconds: 5)).listen((scanResult) {
      if (!devices.contains(scanResult.device.toString())) {
        devices.add(scanResult.device.name);
      }
    }, onDone: () async {
      await storage.writeData(
          filename: 'devices.txt', data: devices.toString());
    }, onError: (error) {});

    final time = DateTime.now();
    _devices = devices.toSet().toList();
    devices.toSet().toList();
    _lastScanTime =
        '${time.day}/${time.month}/${time.year} ${time.hour}:${time.minute}';
    return devices;
  }

  void stopScan() {
    flutterBlue.stopScan();
  }
}
