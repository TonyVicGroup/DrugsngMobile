import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

class Encryption {
  final String key, data;
  const Encryption(this.key, this.data);

  Map<String, String> toMap() => {'data': data, 'key': key};

  @override
  String toString() => 'Encryption($key, $data)';

  ///

  static final _encryptionIV = IV.fromUtf8('DrugsngPassword');

  factory Encryption.encryptString(String value) {
    final key = Key.fromSecureRandom(16);

    final encrypted = Encrypter(AES(key)).encrypt(value, iv: _encryptionIV);

    return Encryption(_encryptWithRSA(key.base64), encrypted.base64);
  }

  static final _rSAEncrypter = Encrypter(RSA(
    publicKey: RSAKeyParser().parse(
      '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAkFpdobZv/tjGzf8xXcXO\nPwk/U3aEgypAi1sgKWnzPglnI7L+5ze91QzDJle6xq0l5KXmM9pnE39N4q4jOqdW\nXW6tefXbbzqZSEW+5bsB1t1Ymu4DUh0XOGlOHKRMlUoAgQYDdYYyo1yQ+eQrFlpC\nw93iPX297Vovgm/qAffeczgUb90NeYkUxqS5G/iPWqkzYbaDWYFK5O5cfDnOf3RR\nCEMeSUsGQ8XHRdyNBBkWY4LsyZh2jDWaYYgVP0/s9xTtMn3q7kaULUgCF0F6r1Z+\nIwry9py7kTRypt2p10zoPB0DAW49lgXT8UuPUXjF2yOcRdUBHvC9CNSppCI0E1uo\nkwIDAQAB\n-----END PUBLIC KEY-----',
    ) as RSAPublicKey,
  ));

  static String _encryptWithRSA(String value) {
    final encrypted = _rSAEncrypter.encrypt(value);
    return encrypted.base64;
  }
}
