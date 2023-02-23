import 'dart:convert';
import 'package:asn1lib/asn1lib.dart';

class KCPSKeys {
  KCPSKeys._privateConstructor();
  static final KCPSKeys _instance = KCPSKeys._privateConstructor();
  static KCPSKeys get instance => _instance;

  String encodePublicKeyToPemPKCS1(publicKey) {
    final sequence = ASN1Sequence();

    sequence.add(ASN1Integer(publicKey!.modulus!));
    sequence.add(ASN1Integer(publicKey!.exponent!));

    final dataBase64 = base64.encode(sequence.encodedBytes);
    return dataBase64;
  }

  String encodePrivateKeyToPemPKCS1(privateKey) {
    final sequence = ASN1Sequence();

    final version = ASN1Integer(BigInt.from(0));
    final modulus = ASN1Integer(privateKey.n!);
    final publicExponent = ASN1Integer(privateKey.exponent!);
    final privateExponent = ASN1Integer(privateKey.privateExponent!);
    final p = ASN1Integer(privateKey.p!);
    final q = ASN1Integer(privateKey.q!);
    final dP = privateKey.privateExponent! % (privateKey.p! - BigInt.from(1));
    final exp1 = ASN1Integer(dP);
    final dQ = privateKey.privateExponent! % (privateKey.q! - BigInt.from(1));
    final exp2 = ASN1Integer(dQ);
    final iQ = privateKey.q!.modInverse(privateKey.p!);
    final co = ASN1Integer(iQ);

    sequence.add(version);
    sequence.add(modulus);
    sequence.add(publicExponent);
    sequence.add(privateExponent);
    sequence.add(p);
    sequence.add(q);
    sequence.add(exp1);
    sequence.add(exp2);
    sequence.add(co);

    final dataBase64 = base64.encode(sequence.encodedBytes);

    return dataBase64;
  }
}
