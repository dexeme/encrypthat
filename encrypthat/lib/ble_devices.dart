import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEDevices extends StatefulWidget {
  const BLEDevices({Key? key}) : super(key: key);
  @override
  State<BLEDevices> createState() => _DispositivosBLEState();
}

class _DispositivosBLEState extends State<BLEDevices> {
  final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  String lastScanTime = 'Nenhum Scan Realizado';
  List devices = [];

  DateTime getCurrentTime() {
    return DateTime.now();
  }

  void startScan() {
    devices = [];
    flutterBlue
        .scan(
      timeout: const Duration(seconds: 5),
    )
        .listen(
      (scanResult) {
        devices.add(scanResult.device.name);
      },
      onDone: () {
        setState(() {
          lastScanTime = getCurrentTime().toString();
        });

        log('Scan Finalizado');
      },
      onError: (error) {
        log('Erro no Scan');
      },
    );
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
        title: Text(lastScanTime),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Dispositivos Encontrados: ${devices.length}'),
            Text('Último Scan ${lastScanTime.toString()}'),
            Container(
              height: 200,
              color: Colors.green,
              child: ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(devices[index].toString()),
                    textColor: Colors.black,
                  );
                },
              ),
            ),
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
