// ignore_for_file: library_private_types_in_public_api

import 'package:encrypthat/services/encryption/signature_validator.dart';
import 'package:flutter/material.dart';
import '../services/encryption/key_pair_generator.dart';
import '../services/encryption/signature_generator.dart';
import '../storage_manager.dart';

class SignatureValidatorView extends StatefulWidget {
  const SignatureValidatorView({Key? key}) : super(key: key);

  @override
  _SignatureValidatorView createState() => _SignatureValidatorView();
}

class _SignatureValidatorView extends State<SignatureValidatorView> {
  final keyGenerator = KeyPairGenerator.instance;
  final signatureValidator = SignatureValidator.instance;
  final signatureGenerator = SignatureGenerator.instance;
  final storage = StorageManager.instance;

  String signature = '';
  String devicesList = '';
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    _initDevicesList();
  }

  void _initDevicesList() async {
    final devices = await storage.readFileContents(filename: 'devices.txt');
    setState(() {
      devicesList = devices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Validar Assinatura'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              TextButton(
                  onPressed: () {
                    final publicKey = keyGenerator.publicKey;
                    if (publicKey == null) {
                      return;
                    }
                    final signature = signatureGenerator.signature;
                    if (signature == null) {
                      return;
                    }
                    final verify = signatureValidator.verifySignature(
                        signature.toString(), devicesList, publicKey);
                    setState(() {
                      isValid = verify;
                      print(signature.toString());
                      print(devicesList);
                      print(isValid);
                    });
                  },
                  child: const Text('Validar Assinatura')),
              Text('Assinatura: $signature'),
              Text('Válida: $isValid'),
            ])));
  }
}
