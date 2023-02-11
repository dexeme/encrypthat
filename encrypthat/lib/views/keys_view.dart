import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:encrypthat/services/encryption/generate_new_rsa_key.dart'
    as rsa;

import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/key_generators/api.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';

class KeysView extends StatefulWidget {
  const KeysView({Key? key}) : super(key: key);

  @override
  State<KeysView> createState() => _KeysViewState();
}

class _KeysViewState extends State<KeysView> {
  String publicKey = 'Nenhuma chave gerada ainda';
  String privateKey = 'Nenhuma chave gerada ainda';

  generateRSAkeyPair({required int keyLength}) {
    final keyGen = RSAKeyGenerator();

    keyGen.init(ParametersWithRandom(
        RSAKeyGeneratorParameters(BigInt.parse('65537'), keyLength, 64),
        exampleSecureRandom()));

    final myPublic = keyGen.generateKeyPair().publicKey as RSAPublicKey;
    final myPrivate = keyGen.generateKeyPair().privateKey as RSAPrivateKey;

    final keys = keysToStrings(
        AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>(myPublic, myPrivate));
    setState(() {
      publicKey = keys[0];
      privateKey = keys[1];
    });

    return [publicKey, privateKey];
  }

  SecureRandom exampleSecureRandom() {
    final secureRandom = FortunaRandom();
    final random = Random.secure();
    final seeds = <int>[];
    for (var i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
    return secureRandom;
  }

  List keysToStrings(AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> keys) {
    final publicKeyString =
        base64Encode(keys.publicKey.modulus!.toRadixString(16).codeUnits);
    final privateKeyString =
        base64Encode(keys.privateKey.modulus!.toRadixString(16).codeUnits);
    return [publicKeyString, privateKeyString];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Painel Chave RSA'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text('Public Key: $publicKey \n Private Key: $privateKey'),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                    onPressed: () {
                      final keyPair = generateRSAkeyPair(keyLength: 2048);
                      setState(() {
                        publicKey = keyPair[0];
                        privateKey = keyPair[1];
                      });
                    },
                    child: const Text('Gerar = RSA')),
              ])
            ])));
  }
}
