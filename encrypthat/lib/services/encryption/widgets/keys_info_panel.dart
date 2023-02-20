import 'package:flutter/material.dart';
import 'package:encrypthat/constants/constants.dart' as constants;
import 'package:pointycastle/export.dart';

class KeysInfoPanel extends StatelessWidget {
  final RSAPublicKey? publicKey;
  final RSAPrivateKey? privateKey;

  const KeysInfoPanel({
    Key? key,
    required this.publicKey,
    required this.privateKey,
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
        Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Text(
            'Chave Pública',
            style: constants.keysNameStyle,
          ),
        ]),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              privateKey == null
                  ? const Text('Nenhuma Chave Gerada',
                      style: constants.keysInfoStyle)
                  : Flexible(
                      child: Text(privateKey!.modulus.toString(),
                          style: constants.keysInfoStyle),
                    ),
            ],
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Text(
            'Chave Privada',
            style: constants.keysNameStyle,
          ),
        ]),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              publicKey == null
                  ? const Text('Nenhuma Chave Gerada',
                      style: constants.keysInfoStyle)
                  : Flexible(
                      child: Text(publicKey!.modulus.toString(),
                          style: constants.keysInfoStyle),
                    ),
            ],
          ),
        ),
      ]),
    );
  }
}
