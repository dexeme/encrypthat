import 'dart:convert';
import 'package:encrypthat/services/bluetooth/functions/ble_devices_scanner.dart';
import 'package:flutter/material.dart';
import 'package:encrypthat/constants/constants.dart' as constants;
import 'package:flutter/services.dart';
import 'package:encrypthat/services/encryption/functions/key_pair_generator.dart';
import 'package:encrypthat/services/encryption/functions/signature_generator.dart';
import 'package:encrypthat/services/encryption/functions/signature_verifier.dart';

class SignatureInfoPanel extends StatelessWidget {
  final Uint8List? signature;
  final Uint8List? dataToSign;
  final bool? isValid;

  final emptyData = Uint8List.fromList([91, 93]); // '[]' -> Empty Device List
  final keyGenerator = KeyPairGenerator.instance;
  final signatureGenerator = SignatureGenerator.instance;
  final scanner = BLEDevicesScanner.instance;
  final signatureVerifier = SignatureVerifier.instance;

  SignatureInfoPanel({
    Key? key,
    required this.signature,
    required this.dataToSign,
    required this.isValid,
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
        const SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Dispositivos ', style: constants.okStyle),
              Icon(Icons.check_circle, color: constants.okColor, size: 15),
            ],
          )
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          keyGenerator.publicKey == null
              ? Row(
                  children: const [
                    Text('Par de chaves ', style: constants.nullSignatureStyle),
                    Icon(Icons.warning,
                        color: constants.nullSignatureColor, size: 15),
                  ],
                )
              : Row(
                  children: const [
                    Text('Par de chaves ', style: constants.okStyle),
                    Icon(Icons.check_circle,
                        color: constants.okColor, size: 15),
                  ],
                ),
        ]),
        const Divider(
          color: constants.appBarColor,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          dataToSign.toString() == emptyData.toString()
              ? const Text('Sua lista de dispositivos está vazia!',
                  style: constants.signatureStyle)
              : const Text('Lista de dispositivos',
                  style: constants.signatureStyle),
        ]),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: dataToSign == null
              ? const Text('[]', style: constants.keysInfoStyle)
              : Text(scanner.devices.toSet().toList().toString(),
                  style: constants.keysInfoStyle),
        ),
        const SizedBox(
          height: 7,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Text('Assinatura: ', style: constants.signatureStyle),
        ]),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            signature == null
                ? const Text('Você ainda não assinou nada!',
                    style: constants.keysInfoStyle)
                : Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Text(base64Encode(signature!),
                            style: constants.keysValueStyle),
                      ],
                    ),
                  ),
          ],
        ),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Text('Estado da assinatura', style: constants.signatureStyle),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isValid == null
                ? const Text('Aguardando validação',
                    style: constants.nullSignatureStyle)
                : isValid!
                    ? const Text('Válida', style: constants.okStyle)
                    : const Text('Inválida', style: constants.warningStyle),
          ],
        ),
      ]),
    );
  }
}
