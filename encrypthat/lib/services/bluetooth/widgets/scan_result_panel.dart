import 'package:flutter/material.dart';

class ScanResultPanel extends StatelessWidget {
  final List<String> devicesList;
  final DateTime? lastScanTime;

  const ScanResultPanel({
    Key? key,
    required this.devicesList,
    required this.lastScanTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Dispositivos encontrados:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Última vez que o botão foi pressionado: ${lastScanTime?.toString() ?? "-"}',
          style: const TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: devicesList.length,
            itemBuilder: (context, index) {
              return Text(devicesList[index]);
            },
          ),
        ),
      ],
    );
  }
}
