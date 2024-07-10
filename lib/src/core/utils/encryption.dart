import 'dart:math';

import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

class Encryption {
  ///Values in base64
  final String key, data;
  const Encryption(this.key, this.data);

  Map<String, String> toMap() => {'data': data, 'key': key};

  @override
  String toString() => 'Encryption($key, $data)';

  ///
  static final _random = Random.secure();
  static String _getRandomString(int length) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(_random.nextInt(chars.length))));
  }

  static final _rSAEncrypter = Encrypter(RSA(
      publicKey: RSAKeyParser().parse(
    '''-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAkFpdobZv/tjGzf8xXcXO
Pwk/U3aEgypAi1sgKWnzPglnI7L+5ze91QzDJle6xq0l5KXmM9pnE39N4q4jOqdW
XW6tefXbbzqZSEW+5bsB1t1Ymu4DUh0XOGlOHKRMlUoAgQYDdYYyo1yQ+eQrFlpC
w93iPX297Vovgm/qAffeczgUb90NeYkUxqS5G/iPWqkzYbaDWYFK5O5cfDnOf3RR
CEMeSUsGQ8XHRdyNBBkWY4LsyZh2jDWaYYgVP0/s9xTtMn3q7kaULUgCF0F6r1Z+
Iwry9py7kTRypt2p10zoPB0DAW49lgXT8UuPUXjF2yOcRdUBHvC9CNSppCI0E1uo
kwIDAQAB
-----END PUBLIC KEY-----''',
  ) as RSAPublicKey));
  static String _encryptKey(Key key) {
    final encrypted = _rSAEncrypter.encryptBytes(key.bytes);
    return encrypted.base64;
  }

  static final _encryptionIV = IV.fromUtf8('DrugsngPassword');
  factory Encryption.encryptString(String value) {
    final keyString = _getRandomString(16);
    final key = Key.fromUtf8(keyString);

    final encrypted = Encrypter(AES(key, mode: AESMode.ecb))
        .encrypt(value, iv: _encryptionIV);

    return Encryption(_encryptKey(key), encrypted.base64);
  }
}
