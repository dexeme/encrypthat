// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:convert';

import 'package:encrypthat/services/bluetooth/ble_devices_scanner.dart';
import 'package:flutter/material.dart';
import 'package:encrypthat/constants/constants.dart' as constants;
import 'package:flutter/services.dart';

import '../../../storage_manager.dart';
import '../key_pair_generator.dart';
import '../signature_generator.dart';
import '../signature_verifier.dart';

class SignatureInfoPanel extends StatelessWidget {
  final Uint8List? signature;
  final Uint8List? dataToSign;
  bool? isValid;

  final emptyData = Uint8List.fromList([91, 93]); // '[]' -> Empty Device List
  final keyGenerator = KeyPairGenerator.instance;
  final signatureGenerator = SignatureGenerator.instance;
  final scanner = BLEDevicesScanner.instance;
  final signatureVerifier = SignatureVerifier.instance;

  SignatureInfoPanel({
    Key? key,
    required this.signature,
    required this.dataToSign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: constants.devicesPanelColor,
        boxShadow: [constants.panelShadow],
      ),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 20),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          dataToSign.toString() == emptyData.toString()
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Dispositivos', style: constants.okStyle),
                    Icon(Icons.check_circle,
                        color: constants.okColor, size: 18),
                  ],
                )
              : Row(
                  children: const [
                    Text('Dispositivos ', style: constants.okStyle),
                    Icon(Icons.check_circle,
                        color: constants.okColor, size: 18),
                  ],
                ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          keyGenerator.publicKey == null
              ? Row(
                  children: const [
                    Text('Par de chaves ', style: constants.nullSignatureStyle),
                    Icon(Icons.warning,
                        color: constants.nullSignatureColor, size: 18),
                  ],
                )
              : Row(
                  children: const [
                    Text('Par de chaves ', style: constants.okStyle),
                    Icon(Icons.check_circle,
                        color: constants.okColor, size: 18),
                  ],
                ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          signatureGenerator.signature == null
              ? Row(
                  children: const [
                    Text('Assinatura ', style: constants.nullSignatureStyle),
                    Icon(Icons.warning,
                        color: constants.nullSignatureColor, size: 18),
                  ],
                )
              : Row(
                  children: const [
                    Text('Assinatura ', style: constants.okStyle),
                    Icon(Icons.check_circle,
                        color: constants.okColor, size: 18),
                  ],
                ),
        ]),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          dataToSign.toString() == emptyData.toString()
              ? const Text('Sua lista de dispositivos está vazia!',
                  style: constants.keysInfoStyle)
              : const Text('Sua lista de dispositivos:',
                  style: constants.keysInfoStyle),
        ]),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: dataToSign == null
              ? const Text('[]', style: constants.keysInfoStyle)
              : Text(scanner.devices.toSet().toList().toString(),
                  style: constants.keysInfoStyle),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              signature == null
                  ? const Text('Você ainda não assinou nada!',
                      style: constants.keysInfoStyle)
                  : Flexible(
                      child: Text('Sua assinatura: ${base64Encode(signature!)}',
                          style: constants.keysInfoStyle),
                    ),
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: const []),
      ]),
    );
  }
}
