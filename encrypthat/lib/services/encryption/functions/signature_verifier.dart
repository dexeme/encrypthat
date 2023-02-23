import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypthat/services/encryption/functions/signature_generator.dart';
import 'package:encrypthat/utils/storage_manager.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/signers/rsa_signer.dart';
import 'package:encrypthat/services/encryption/functions/key_pair_generator.dart';

class SignatureVerifier {
  SignatureVerifier._privateConstructor();
  static final SignatureVerifier _instance =
      SignatureVerifier._privateConstructor();
  static SignatureVerifier get instance => _instance;
  final storage = StorageManager.instance;
  final keyPairGenerator = KeyPairGenerator.instance;
  final signatureGenerator = SignatureGenerator.instance;

  Uint8List? dataToSign;
  RSAPublicKey? publicKey;
  Uint8List? signature;
  bool? isValid;
  bool? isVerifying;

  get getIsVerifying => isVerifying;
  get getPublicKey => publicKey;
  get getDataToSign => dataToSign;
  get getSignature => signature;
  get getIsValid => isValid;

  void initVariables() {
    _initSignature();
    _initDataToSign();
    _initPublicKey();
  }

  void _initDataToSign() async {
    final dataString = await storage.readFileContents(filename: 'devices.txt');
    dataToSign = Uint8List.fromList(utf8.encode(dataString));
  }

  void _initPublicKey() {
    publicKey = keyPairGenerator.publicKey;
    if (publicKey == null) {
      throw Exception('Public key is null');
    }
  }

  void _initSignature() async {
    final signature = signatureGenerator.getSignature;
    if (signature == null) {
      throw Exception('Signature is null');
    }
  }

  bool verify(Uint8List dataToSign) {
    isVerifying = true;
    final sign = signatureGenerator.getSignature;
    final sig = RSASignature(sign);

    final verifier = RSASigner(SHA256Digest(), '0609608648016503040201');
    final publicKey = keyPairGenerator.publicKey;
    if (publicKey == null) {
      throw Exception('Public key is null');
    }

    verifier.init(false, PublicKeyParameter<RSAPublicKey>(publicKey));

    try {
      final isValid = verifier.verifySignature(dataToSign, sig);
      this.isValid = isValid;
      isVerifying = false;
      return isValid;
    } catch (e) {
      return false;
    }
  }
}
