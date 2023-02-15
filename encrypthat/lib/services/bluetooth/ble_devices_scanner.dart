import 'dart:developer';
import 'package:encrypthat/storage_manager.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEDevicesScanner {
  BLEDevicesScanner._privateConstructor();
  static final BLEDevicesScanner _instance =
      BLEDevicesScanner._privateConstructor();
  static BLEDevicesScanner get instance => _instance;

  BLEDevicesScanner();
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  StorageManager storage = StorageManager.instance;
  String lastScanTime = 'Nenhum Scan Realizado';
  List<String> devices = [];

  String getLastScanTimeFormatted() {
    lastScanTime = DateTime.now().toString();
    return lastScanTime;
  }

  List<String> startScan() {
    flutterBlue.scan(timeout: const Duration(seconds: 5)).listen((scanResult) {
      if (!devices.contains(scanResult.device.toString())) {
        devices.add(scanResult.device.name);
      }
      devices = devices.toSet().toList();
      log('Dispositivo Encontrado: ${scanResult.device.name}');
    }, onDone: () async {
      log('Scan Finalizado');
      log(devices.toString());
      await storage.writeData(
          filename: 'devices.txt', data: devices.toString());
    }, onError: (error) {
      log('Erro no Scan $error');
    });
    log('Dispositivos Encontrados: $devices');
    return devices;
  }

  void stopScan() {
    flutterBlue.stopScan();
  }
}
