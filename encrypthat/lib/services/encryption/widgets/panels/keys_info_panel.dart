import 'package:encrypthat/services/encryption/widgets/functions/key_pair_generator.dart';
import 'package:flutter/material.dart';
import 'package:encrypthat/constants/constants.dart' as constants;
import 'package:pointycastle/export.dart';

class KeysInfoPanel extends StatelessWidget {
  final RSAPublicKey? publicKey;
  final RSAPrivateKey? privateKey;
  final keyGenerator = KeyPairGenerator.instance;

  KeysInfoPanel({
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
              keyGenerator.publicKeyString == null
                  ? const Text('Nenhuma Chave Gerada',
                      style: constants.keysInfoStyle)
                  : Flexible(
                      child: Text(keyGenerator.publicKeyString!,
                          style: constants.keysValueStyle),
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
              keyGenerator.privateKeyString == null
                  ? const Text('Nenhuma Chave Gerada',
                      style: constants.keysInfoStyle)
                  : Flexible(
                      child: Text(keyGenerator.privateKeyString!,
                          style: constants.keysValueStyle),
                    ),
            ],
          ),
        ),
      ]),
    );
  }
}
