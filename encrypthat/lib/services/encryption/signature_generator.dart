// ignore_for_file: avoid_print

import 'dart:typed_data';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/signers/rsa_signer.dart';
import 'package:encrypthat/storage_manager.dart';
import 'key_pair_generator.dart';

class SignatureGenerator {
  SignatureGenerator._privateConstructor();
  static final SignatureGenerator _instance =
      SignatureGenerator._privateConstructor();
  static SignatureGenerator get instance => _instance;

  final keyPairGenerator = KeyPairGenerator.instance;
  final storage = StorageManager.instance;

// private key, data to sign, public key, signature
  Uint8List? dataToSign;
  Uint8List? signature;

  AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>? keyPair;

  void initVariables() {}

  get getDataToSign => dataToSign;
  get getSignature => signature;
  get getKeyPair => keyPair;

  Uint8List rsaSign(Uint8List dataToSign) {
    final signer = RSASigner(SHA256Digest(), '0609608648016503040201');

    final privateKey = keyPairGenerator.privateKey;
    if (privateKey == null) {
      print('Private key is null');
      throw Exception('Private key is null');
    }

    signer.init(
        true, PrivateKeyParameter<RSAPrivateKey>(privateKey)); // true=sign

    final sig = signer.generateSignature(dataToSign);

    signature = sig.bytes;

    return sig.bytes;
  }
}
