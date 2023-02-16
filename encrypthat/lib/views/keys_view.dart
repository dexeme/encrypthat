import 'package:encrypthat/services/encryption/key_pair_generator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/encryption/widgets/key_length_dropdown.dart';
import '../storage_manager.dart';

class KeysView extends StatefulWidget {
  const KeysView({Key? key}) : super(key: key);

  @override
  State<KeysView> createState() => _KeysViewState();
}

class _KeysViewState extends State<KeysView>
    with AutomaticKeepAliveClientMixin {
  KeyPairGenerator generator = KeyPairGenerator.instance;
  StorageManager storage = StorageManager.instance;
  int keyLength = 64;
  String publicKey = '';
  String privateKey = '';

  @override
  void initState() {
    super.initState();
    _initKeys();
  }

  void _initKeys() async {
    final readPublicKey =
        await storage.readFileContents(filename: 'public.pem') == ''
            ? 'Not defined yet'
            : await storage.readFileContents(filename: 'public.pem');
    final readPrivateKey =
        await storage.readFileContents(filename: 'private.pem') == ''
            ? 'Not defined yet'
            : await storage.readFileContents(filename: 'private.pem');
    setState(() {
      publicKey = readPublicKey;
      privateKey = readPrivateKey;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel Chave RSA - Keys view'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              KeyLengthDropdown(
                onValueChanged: (value) {
                  setState(() {
                    keyLength = value;
                  });
                },
              ),
              TextButton(
                onPressed: () async {
                  final keys =
                      generator.generateRSAkeyPair(keyLength: keyLength);

                  final publicKey = keys.publicKey;
                  final privateKey = keys.privateKey;

                  final lista = generator.keysToStrings(publicKey, privateKey);

                  setState(() {
                    print(lista[0]);
                    print(lista[1]);
                    this.publicKey = lista[0];
                    this.privateKey = lista[1];
                  });
                },
                child: const Text('Gerar Chave RSA'),
              ),
              TextButton(
                  onPressed: () => context.go('/'),
                  child: const Text('Voltar')),
              Text('Chave Pública -> $publicKey'),
              Text('Chave Privada -> $privateKey'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
