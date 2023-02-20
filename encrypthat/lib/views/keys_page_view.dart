import 'package:encrypthat/services/encryption/key_pair_generator.dart';

import 'package:flutter/material.dart';
import 'package:encrypthat/constants/constants.dart' as constants;
import 'package:pointycastle/api.dart' as pc;
import 'package:pointycastle/asymmetric/api.dart' as pc;
import '../icons.dart';
import '../services/encryption/widgets/key_length_dropdown.dart';
import '../services/encryption/widgets/generate_keys_button.dart';
import '../services/encryption/widgets/keys_info_panel.dart';
import '../widgets/bottom_nav_bar.dart';

class KeysPage extends StatefulWidget {
  const KeysPage({super.key});

  @override
  State<KeysPage> createState() => _KeysPageState();
}

class _KeysPageState extends State<KeysPage> {
  KeyPairGenerator keyPairGenerator = KeyPairGenerator.instance;
  int keyLength = 64;
  pc.AsymmetricKeyPair<pc.RSAPublicKey, pc.RSAPrivateKey>? _keyPair;
  pc.RSAPublicKey? _publicKey;
  pc.RSAPrivateKey? _privateKey;

  @override
  void initState() {
    super.initState();
    _publicKey = keyPairGenerator.publicKey;
    print(_publicKey);
    print(_privateKey);
    _privateKey = keyPairGenerator.privateKey;
  }

  String lastScanTime = 'Nenhum Scan Realizado';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.backgroundColor,
      appBar: AppBar(
        title: const Text('ENCRYPTHAT', style: constants.boldFont),
        leading: const Icon(CustomIcons.logo),
        backgroundColor: constants.appBarColor,
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  height: 70,
                ),
                Text('CHAVES', style: constants.boldFont),
              ],
            ),
            Expanded(
              child: KeysInfoPanel(
                publicKey: _publicKey,
                privateKey: _privateKey,
              ),
            ),
            Column(
              children: [
                KeyLengthDropdown(onValueChanged: (value) {
                  setState(() {
                    keyLength = value;
                  });
                }),
                const SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GenerateKeysButton(
                      onPressed: () {
                        keyPairGenerator.generateRSAkeyPair(
                            keyLength: keyLength);
                        setState(() {
                          _publicKey = keyPairGenerator.publicKey;
                          _privateKey = keyPairGenerator.privateKey;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
