import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/signers/rsa_signer.dart';

class SignatureGenerator {
  SignatureGenerator._privateConstructor();
  static final SignatureGenerator _instance =
      SignatureGenerator._privateConstructor();
  static SignatureGenerator get instance => _instance;

  String? _signature;

  String? get signature => _signature;

  String sign(String plainText, RSAPrivateKey privateKey) {
    var signer = RSASigner(SHA256Digest(), "0609608648016503040201");
    signer.init(true, PrivateKeyParameter<RSAPrivateKey>(privateKey));

    _signature = base64Encode(signer
        .generateSignature(Uint8List.fromList(plainText.codeUnits))
        .bytes);

    return _signature!;
  }
}
