import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/signers/rsa_signer.dart';

class SignatureValidator {
  SignatureValidator._privateConstructor();
  static final SignatureValidator _instance =
      SignatureValidator._privateConstructor();
  static SignatureValidator get instance => _instance;

  bool? _isValid;
  bool? get isValid => _isValid;

  bool verifySignature(
      String signedMessage, String message, RSAPublicKey publicKey) {
    var signer = RSASigner(SHA256Digest(), "0609608648016503040201");
    signer.init(false, PublicKeyParameter<RSAPublicKey>(publicKey));
    _isValid = signer.verifySignature(Uint8List.fromList(message.codeUnits),
        RSASignature(base64Decode(signedMessage)));
    return _isValid!;
  }
}
