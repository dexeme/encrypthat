import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:pointycastle/key_generators/api.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/random/fortuna_random.dart';

class KeyPairGenerator {
  KeyPairGenerator._privateConstructor();
  static final KeyPairGenerator _instance =
      KeyPairGenerator._privateConstructor();
  static KeyPairGenerator get instance => _instance;

  AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>? _keyPair;
  AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>? get keyPair => _keyPair;
  RSAPublicKey? get publicKey => _keyPair?.publicKey;
  RSAPrivateKey? get privateKey => _keyPair?.privateKey;


  AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey> generateRSAkeyPair(
      {required int keyLength}) {
    final keyGen = RSAKeyGenerator();

    keyGen.init(
      ParametersWithRandom(
          RSAKeyGeneratorParameters(
            BigInt.parse('65537'),
            keyLength,
            5,
          ),
          exampleSecureRandom()),
    );
    final keyPair = keyGen.generateKeyPair();
    final publicKey = keyPair.publicKey as RSAPublicKey;
    final privateKey = keyPair.privateKey as RSAPrivateKey;
    final keyPairRSA =
        AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>(publicKey, privateKey);
    _keyPair = keyPairRSA;
    return keyPairRSA;
  }

  SecureRandom exampleSecureRandom() {
    var secureRandom = FortunaRandom();
    var random = Random.secure();
    List<int> seeds = <int>[];
    for (var i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
    return secureRandom;
  }
}
