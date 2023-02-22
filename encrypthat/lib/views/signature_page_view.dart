import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypthat/services/encryption/widgets/buttons/sign_list_button.dart';
import 'package:encrypthat/services/encryption/widgets/buttons/verify_signature_button.dart';
import 'package:encrypthat/services/encryption/widgets/functions/key_pair_generator.dart';
import 'package:encrypthat/services/encryption/widgets/functions/signature_generator.dart';
import 'package:encrypthat/services/encryption/widgets/functions/signature_verifier.dart';
import 'package:encrypthat/services/encryption/widgets/panels/signature_info_panel.dart';
import 'package:encrypthat/utils/storage_manager.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:flutter/material.dart';
import 'package:encrypthat/constants/constants.dart' as constants;


class SignaturePage extends StatefulWidget {
  const SignaturePage({super.key});

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

Uint8List? signature;
Uint8List? dataToSign;
bool? isValid;

class _SignaturePageState extends State<SignaturePage> {
  final storage = StorageManager.instance;
  final keyPairGenerator = KeyPairGenerator.instance;
  final signatureGenerator = SignatureGenerator.instance;
  final signatureVerifier = SignatureVerifier.instance;

  RSAPublicKey? _publicKey;
  RSAPrivateKey? _privateKey;
  bool isSignatureNull = false;

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
            isValid: isValid,
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
                    isValid = signatureVerifier.verify(
                      dataToSign!,
                    );
                    setState(() {
                      isValid = isValid;
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
