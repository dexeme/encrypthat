import 'dart:math';
import 'dart:typed_data';
import 'package:encrypthat/services/encryption/widgets/functions/kpcs_keys.dart';
import 'package:pointycastle/export.dart';

class KeyPairGenerator {
  KeyPairGenerator._privateConstructor();
  static final KeyPairGenerator _instance =
      KeyPairGenerator._privateConstructor();
  static KeyPairGenerator get instance => _instance;

  final kpcsKeys = KCPSKeys.instance;

  AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>? _keyPair;
  AsymmetricKeyPair<RSAPublicKey, RSAPrivateKey>? get keyPair => _keyPair;
  RSAPublicKey? get publicKey => _keyPair?.publicKey;
  RSAPrivateKey? get privateKey => _keyPair?.privateKey;
  String? _publicKeyString;
  String? _privateKeyString;
  String? get publicKeyString => _publicKeyString;
  String? get privateKeyString => _privateKeyString;

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

    _publicKeyString = kpcsKeys.encodePublicKeyToPemPKCS1(publicKey);
    _privateKeyString = kpcsKeys.encodePrivateKeyToPemPKCS1(privateKey);

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
