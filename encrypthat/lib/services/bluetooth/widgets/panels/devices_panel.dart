import 'package:flutter/material.dart';
import 'package:encrypthat/constants/constants.dart' as constants;

class DevicesPanel extends StatelessWidget {
  final List<String> devicesList;
  final String? lastScanTime;

  const DevicesPanel({
    Key? key,
    required this.devicesList,
    required this.lastScanTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: constants.devicesPanelColor,
        boxShadow: [constants.panelShadow],
      ),
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              devicesList.isEmpty
                  ? const Text(
                      'SUA LISTA DE DISPOSITIVOS ESTÁ VAZIA!',
                      style: constants.boldFont,
                    )
                  : const Text(
                      'DISPOSITIVOS ENCONTRADOS:',
                      style: constants.boldFont,
                    ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: devicesList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    devicesList[index].toUpperCase(),
                    style: constants.regularFont,
                  ),
                  leading: const Icon(Icons.arrow_right),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
