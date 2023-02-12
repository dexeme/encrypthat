import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/key_generators/api.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';

class KeyPairGenerator {
  KeyPairGenerator();

  List<String> generateRSAkeyPair({required int keyLength}) {
    final keyGen = RSAKeyGenerator();

    keyGen.init(ParametersWithRandom(
        RSAKeyGeneratorParameters(BigInt.parse('65537'), keyLength, 64),
        exampleSecureRandom()));

    var publicKey = keyGen.generateKeyPair().publicKey as RSAPublicKey;
    var privateKey = keyGen.generateKeyPair().privateKey as RSAPrivateKey;

    final keysAsString = _keysToStrings(publicKey, privateKey);

    return keysAsString;
  }

  SecureRandom exampleSecureRandom() {
    final secureRandom = FortunaRandom();
    final random = Random.secure();
    final seeds = <int>[];
    for (var i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
    return secureRandom;
  }

  List<String> _keysToStrings(publicKey, privateKey) {
    final publicKeyString =
        base64Encode(publicKey.modulus!.toRadixString(16).codeUnits);
    final privateKeyString =
        base64Encode(privateKey.modulus!.toRadixString(16).codeUnits);
    return [publicKeyString, privateKeyString];
  }
}
