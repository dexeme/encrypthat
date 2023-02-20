import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/api.dart' as pc;
import 'package:encrypthat/services/encryption/key_pair_generator.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:flutter/material.dart';
import 'package:encrypthat/constants/constants.dart' as constants;
import '../icons.dart';
import '../services/encryption/signature_generator.dart';
import '../services/encryption/signature_verifier.dart';
import '../services/encryption/widgets/sign_list_button.dart';
import '../services/encryption/widgets/signature_info_panel.dart';
import '../services/encryption/widgets/verify_signature_button.dart';
import '../storage_manager.dart';
import '../widgets/bottom_nav_bar.dart';

class SignaturePage extends StatefulWidget {
  const SignaturePage({super.key});

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

Uint8List? signature;
Uint8List? dataToSign;
bool isVerified = false;
bool isSignatureNull = false;

class _SignaturePageState extends State<SignaturePage> {
  final storage = StorageManager.instance;
  final keyPairGenerator = KeyPairGenerator.instance;
  final signatureGenerator = SignatureGenerator.instance;
  final signatureVerifier = SignatureVerifier.instance;

  RSAPublicKey? _publicKey;
  RSAPrivateKey? _privateKey;

  @override
  void initState() {
    super.initState();
    _initDataToSign();
    _publicKey = keyPairGenerator.publicKey;
    _privateKey = keyPairGenerator.privateKey;
  }

  void _initDataToSign() async {
    final dataString = await storage.readFileContents(filename: 'devices.txt');
    dataToSign = Uint8List.fromList(utf8.encode(dataString));
    setState(() {
      dataToSign = dataToSign;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(
              height: 70,
            ),
            Text('ASSINATURA', style: constants.boldFont),
          ],
        ),
        Expanded(
          child: SignatureInfoPanel(
            dataToSign: dataToSign,
            signature: signature,
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [],
            ),
          ],
        ),
        Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SignListButton(
              onPressed: () {
                signature = signatureGenerator.sign(dataToSign!);
                setState(() {
                  signature = signature;
                  isSignatureNull = false;
                });
              },
            ),
          ])
        ]),
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VerifySignatureButton(
                  onPressed: () {
                    if (signature == null) {
                      setState(() {
                        isSignatureNull = true;
                      });
                      return;
                    }
                    isVerified = signatureVerifier.verify(
                      dataToSign!,
                    );
                    setState(() {
                      isVerified = isVerified;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
