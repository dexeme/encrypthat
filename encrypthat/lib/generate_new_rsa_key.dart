import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fast_rsa/fast_rsa.dart';

class GenerateNewRSAKey extends StatefulWidget {
  const GenerateNewRSAKey({Key? key}) : super(key: key);

  @override
  State<GenerateNewRSAKey> createState() => _GenerateNewRSAKeyState();
}

class _GenerateNewRSAKeyState extends State<GenerateNewRSAKey> {
  String publicKey = '';
  String privateKey = '';

  void generateKeyPair() async {
    var data = await RSA.generate(2048);
    log('Generated RSA key pair');
    log(data.toString());

    log('Public Key: $publicKey');
    log('Private Key: $privateKey');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gerar Nova Chave RSA'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  TextButton(
                    onPressed: () {
                      generateKeyPair();
                      Navigator.pop(context);
                    },
                    child: const Text('Gerar Chave RSA'),
                  ),
                ]),
              ]),
        ));
  }
}
