import 'dart:developer';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEDevicesScanner {
  BLEDevicesScanner._privateConstructor();
  static final BLEDevicesScanner _instance =
      BLEDevicesScanner._privateConstructor();
  static BLEDevicesScanner get instance => _instance;

  BLEDevicesScanner();
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  String lastScanTime = 'Nenhum Scan Realizado';
  List devices = [];

  String getLastScanTimeFormatted() {
    lastScanTime = DateTime.now().toString();
    return lastScanTime;
  }

  List startScan() {
    flutterBlue.scan(timeout: const Duration(seconds: 5)).listen((scanResult) {
      devices.add(scanResult.device.name);
      devices = devices.toSet().toList();
      log('Dispositivo Encontrado: ${scanResult.device.name}');
    }, onDone: () {
      log('Scan Finalizado');
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
