// ignore_for_file: library_private_types_in_public_api

import 'package:encrypthat/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/encryption/key_pair_generator.dart';
import '../services/encryption/signature_generator.dart';

class SignatureGeneratorView extends StatefulWidget {
  const SignatureGeneratorView({Key? key}) : super(key: key);

  @override
  _SignatureGeneratorViewState createState() => _SignatureGeneratorViewState();
}

class _SignatureGeneratorViewState extends State<SignatureGeneratorView>
    with AutomaticKeepAliveClientMixin {
  final storage = StorageManager.instance;
  final keyGenerator = KeyPairGenerator.instance;
  final signatureGenerator = SignatureGenerator.instance;

  String signature = '';
  String devicesList = '';

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
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assinar Lista'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                final privateKey = keyGenerator.privateKey;
                if (privateKey == null) {
                  return;
                }
                final signature =
                    signatureGenerator.sign(devicesList, privateKey);
                setState(() {
                  this.signature = signature;
                });
              },
              child: const Text('Assinar'),
            ),
            Text('Lista de dispositivos: $devicesList'),
            Text('Assinatura: $signature'),
            TextButton(
              onPressed: () => context.go('/'),
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
